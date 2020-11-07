module Chid
  module Commands
    module Installs
      class Dotfile < Command

        command :'install dotfile'

        self.summary = 'Install the Dotfile'
        self.description = <<-DESC

Usage:

  $ chid install dotfile

    For Linux users will install through curl

    For OSx users will install through curl

        DESC
        self.arguments = []

        def run
          puts "\nInstalling the YADR Dotfiles..."

          puts "\nCreating undodir folder"
          system('mkdir ~/.vim/undodir')

          ::ChidConfig.on_linux do
            puts "\nInstalling all dependencies"
            system('sudo apt-get update')
            system('sudo apt-get install curl')
            system('sudo apt-get install tmux')
            system('sudo apt-get install xclip')
            system('sudo apt install npm')
            system('sudo apt-get install ripgrep')
            system('sudo apt-get install fzf')
            system('sudo apt-get install zsh')
            system('sudo apt install git-all')
          end

          puts "\nDownloading tmux config"
          system('curl -o ~/.tmux.conf https://gist.githubusercontent.com/rachidcalazans/b9ede3f6e49450b41a5bbaff9ccc8cad/raw/f0c1fe18b22772ad04bf322aeb49df993e73877c/.tmux.conf')

          puts "\nDownloading .vimrc"
          system('curl -o ~/.vimrc https://gist.githubusercontent.com/rachidcalazans/e7b7ee668b9a8b247b3a9c20e5669366/raw/84af22bb3c5fb24b01aa8a01e8b783f85a6928b5/.vimrc')

          puts "\nDownloading coc-settings.json"
          system('curl -o ~/.vim/coc-settings.json https://gist.githubusercontent.com/rachidcalazans/a29bdedde40b328a14279bda419ccd4f/raw/59492c4096d77aef4690b1516d9c9f597fafd205/coc-settings.json')

          puts "\nInstalling Oh My ZSH"
          system('sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"')

          puts "\nInstalling all Vim Plugins"
          system("vim +'PlugInstall --sync' +qa")

          puts "\nDotfiles installed successfully"
        end

      end
    end
  end
end
