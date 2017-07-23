module Chid
  module Commands
    class Init < Command

      self.summary = 'Generate a .chid.config file on root directory'
      self.description = <<-DESC
        Creates a .chid.config file on root directory if none .chid.config file exists.

        To access that file will be created in `~/.chid.config`
      DESC
      self.arguments = []

      def run
        create_or_update_chid_config_file
      end

      private
      def chid_config_path
       @chid_config_path ||= ::Chid::chid_config_path
      end

      def create_or_update_chid_config_file
        print_informations
        dump_on_chid_config_file(chid_configurations)
      end

      def print_informations
        print "\n--- Installing chid ---\n "
        print "\nCreating the " unless chid_config_file_exist?
        print "\nUpdating the " if chid_config_file_exist?
        print "~/.chid.config ".blue
        print "file\n"
      end

      def dump_on_chid_config_file(configurations)
        File.open(chid_config_path, 'w') do |file|
          YAML.dump(configurations, file)
        end
      end

      def chid_configurations
        return base_configurations unless chid_config_file_exist?

        data = YAML.load_file chid_config_path
        data[:chid][:workstations] = data[:chid].fetch(:workstations, {})
        data
      end

      def base_configurations
        {
          chid: {
            workstations: {}
          }
        }
      end

      def chid_config_file_exist?
        File.exist?(chid_config_path)
      end

    end
  end
end
