module Chid
  module Commands
    class Config < Command

      command :'config'

      self.summary = 'Open the .chid.config file using any source you want. By default is vim.'
      self.description = <<-DESC

Usage:

  $ chid config
    or
  $ chid config -editor [EDITOR_NAME]

    Open the .chid.config file using any source you want. By default is vim.

    Example how chid will open the config file:
      $ chid config -editor vim

      It will be executed:
      $ vim ~/.chid.config

Options:

  -editor EDITOR_NAME

      DESC
      self.arguments = ['-editor']

      def run
        puts "\nOpening the .chid.config..."
        system("#{editor} #{chid_config_path}")
      end

      private

      def editor
        options['-editor']&.compact&.join || 'vim'
      end

      def chid_config_path
       @chid_config_path ||= ::Chid::chid_config_path
      end
    end
  end
end

