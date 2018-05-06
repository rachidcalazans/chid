module Chid
  module Commands
    module Tmux
      class Open < Command

        command :'tmux open'

        self.summary = 'Open a specific tmux template'
        self.description = <<-DESC

Usage:

  $ chid tmux open
    or
  $ chid tmux open -name some_template_name

    Open the template.

    To see all templates you can run

      $ chid tmux list

    If no options are specified, chid will show a list of Templates created
    to be selected.

Options:

  -name template_name  Open the specifc template called 'template_name'
  -n "base two"           Open the specific template called 'base two'

        DESC
        self.arguments = ['-name', '-n']

        def run
          template_name = template_name_from_options
          template_name = select_template if template_name.empty?

          open_template(template_name)
        end

        private

        # Returns the template name mapped from the values of the options attribute.
        # Will remove all nil values and join the array of values into String
        #
        # @return [String] Mapped values from options attribute
        #                  If the options does not exist, will return empty String #=> ""
        #
        # @example Template Name
        #   options = {'-name' => ['base', 'two']}
        #
        #   template_name #=> 'base two'
        #
        def template_name_from_options
          @template_name ||= self.class.arguments.map { |a| options[a] }.compact.join(' ')
        end

        def chid_config
          ::Chid.chid_config
        end

        def templates
          @templates ||= chid_config.all_tmux_templates
        end

        def select_template
          prompt  = TTY::Prompt.new
          choices = templates.keys
          selected_template = prompt.select('Choose a template to open', choices)
          selected_template
        end

        def open_template(template_name)
          puts "\nOpening Template #{template_name}"
          commands = templates[template_name.to_sym]

          exist_tmux_session = system("tmux ls | grep -c #{template_name}")

          if exist_tmux_session
            system("tmux attach -t #{template_name}")
          else
            system(commands.join('').gsub('$$template_name$$', template_name.to_s))
          end
        end
      end
    end
  end
end

