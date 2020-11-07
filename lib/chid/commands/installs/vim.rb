module Chid
  module Commands
    module Installs
      class Vim < Command

        command :'install vim'

        self.summary = 'Install vim and gvim'
        self.description = <<-DESC

Usage:
  $ chid install vim or chid install gvim

    For Linux users will install through apt-get

    For OSx users will install through brew

        DESC
        self.arguments = []

        def run
          puts "\nInstalling vim..."

          is_vim = do_vim?
          is_gvim = do_gvim?

          ::ChidConfig.on_linux do
            system('sudo apt update')

            if is_vim
              system('sudo add-apt-repository ppa:jonathonf/vim')
              system('sudo apt update')
              system('sudo apt install vim')
            end

            system('sudo apt-get install vim-gnome') if is_gvim
          end

          ::ChidConfig.on_osx do
            system('brew update')
            system('brew install vim')
          end

          puts "\nVim installed successfully" if is_vim
          puts "\nGvim installed successfully" if is_gvim

          puts "\nNothing installed =(" unless is_vim || is_gvim
        end

        def prompt
          @prompt ||= TTY::Prompt.new
        end

        def do_vim?
          answers = ['Yes','No']
          should_install_vim = prompt.select('Install vim ?', answers)
          should_install_vim == 'Yes'
        end

        def do_gvim?
          answers = ['Yes','No']
          should_install_gvim = prompt.select('Install gvim too?', answers)
          should_install_gvim == 'Yes'
        end

      end
    end
  end
end
