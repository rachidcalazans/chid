module Chid
  class Command

    class << self

      attr_accessor :summary, :description, :arguments

      COMMANDS = {}

      def command(cmd)
        COMMANDS[cmd] = self.to_s
      end

      def help
        if self.description.nil?
          commands = String.new
          COMMANDS.keys.each {|k| commands <<  "  #{k.to_s}\n" }
          self.description = <<-DESC
Usage:

  $ chid [COMMAND]

   To see what the Command do:

    $ chid [COMMAND] -h

Commands:

#{commands}
          DESC
        end

        puts summary
        print description
      end

      def run(argv)
        command_key = command_key(argv)
        return self.help unless command_key_is_included?(command_key)
        invoke(argv)
      end

      # Returns a mapped options with your values from @argv
      #
      # @param [Array<String>] argv
      #        The arguments passed from input.
      #
      # @return [Hash<String, Array>] Mapped options with your values
      #         The keys of hash are the options and the values of hash
      #         are all values for the option.
      #
      # @example Map an argv
      #   argv = ['init', '-option_1', 'value_for_option_1']
      #
      #   map_options_with_values(argv) #=> {'-option1' => ['value_for_option_1']}
      #
      def map_options_with_values(argv)
        return argv.reduce({}) do |options, arg|
          new_options = options

          if arg_is_an_option?(arg)
            new_options[arg] = []
            next(new_options)
          end

         options_with_values(new_options, arg)
        end
      end

      private

      def arg_is_an_option?(arg)
        arg.start_with?('-')
      end

      def options_with_values(options, arg)
        new_options = options
        last_option = new_options.keys.last
        new_options[last_option] << arg if last_option

        new_options
      end

      def command_key_is_included?(command_key)
        COMMANDS.include?(command_key)
      end

      # Returns the command key based on argv parameter.
      # That command could be a single or compost command.
      #
      # @param [Array<String>] argv
      #        The arguments passed from input.
      #
      # @return [Sym] the sym of the command
      #
      # @example Get the command_key in an argv
      #   argv = ['init', '-option_1', 'value_for_option_1']
      #
      #   command_key(argv) #=> :init
      #
      #   argv = ['init', 'chid', '-option_1', 'value_for_option_1']
      #
      #   command_key(argv) #=> :'init chid'
      #
      def command_key(argv)
        argv.reduce('') { |command, arg|
          break(command) if arg_is_an_option?(arg)
          command << "#{arg} "
        }.strip.to_sym
      end

      # Convenience method.
      # Instantiate the command and run it with the provided arguments at once.
      #
      # @param [String..., Array<String>] args
      #        The arguments to initialize the command with
      #
      def invoke(argv)
        options = map_options_with_values(argv)
        command = new_command_instance(command_key(argv), options)
        return command.run if has_no_arguments?(options) || has_valid_arguments?(command.class, options)
        command.class.help
      end

      def new_command_instance(command_key, options)
        Object.const_get(COMMANDS[command_key]).new(options)
      end

      def has_no_arguments?(options)
        options.empty?
      end

      def has_valid_arguments?(command_class, options)
        !(command_class.arguments & options.keys).empty?
      end

    end

    # --- Instance methods ---

    public

    attr_reader :options

    def initialize(options)
      @options = options
    end

  end
end
