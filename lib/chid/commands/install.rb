# @deprecated
module Chid
module Commands
  class Install

    def initialize(chid_config_path)
      @chid_config_path = chid_config_path
    end

    def run
      create_or_update_chid_config_file
    end

    private

    attr_reader :chid_config_path

    def create_or_update_chid_config_file
      print "\n--- Installing chid ---\n "
      print "\nCreating the " unless chid_config_file_exist?
      print "\nUpdating the " if chid_config_file_exist?
      print "~/.chid.config ".blue
      print "file\n"

      base_config = chid_configurations

      File.open(chid_config_path, 'w') do |file|
        YAML.dump(base_config, file)
      end
    end

    def chid_configurations
      base_config = {
        chid: {
          workstations: {}
        }
      }

      if chid_config_file_exist?
        data = YAML.load_file chid_config_path
        data[:chid][:workstations] = data[:chid].fetch(:workstations, {})
        base_config = data
      end

      base_config
    end

    def chid_config_file_exist?
      File.exist?(chid_config_path)
    end

  end
end
end
