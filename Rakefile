class String
  def black;          "\e[30m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def gray;           "\e[37m#{self}\e[0m" end

  def bg_black;       "\e[40m#{self}\e[0m" end
  def bg_red;         "\e[41m#{self}\e[0m" end
  def bg_green;       "\e[42m#{self}\e[0m" end
  def bg_brown;       "\e[43m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end
  def bg_magenta;     "\e[45m#{self}\e[0m" end
  def bg_cyan;        "\e[46m#{self}\e[0m" end
  def bg_gray;        "\e[47m#{self}\e[0m" end

  def bold;           "\e[1m#{self}\e[22m" end
  def italic;         "\e[3m#{self}\e[23m" end
  def underline;      "\e[4m#{self}\e[24m" end
  def blink;          "\e[5m#{self}\e[25m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
end

require_relative 'chid_config'
require_relative 'main'
require_relative 'news_api'
require_relative 'currency_api'
require 'yaml'
require 'tty-prompt'

chid_config = ChidConfig.new

task :default => :chid

desc 'Initial configuration for Chid app'
task :init do
  print "Chid is an assistant to help your day-to-day life.\n\n"
  print "You can use it as "
  print "a terminal App ".green
  print "or through "
  print "Rake Tasks".green
  print", having a greater interaction with it.\n\n"

  print "To initialize the app you can run the command: "
  print "$ rake\n".blue
  print "Or the command: "
  print "$ chid\n".blue
  print "But the command "
  print "$ chid ".blue
  print "will work after you reload your profile\n"

  chid_config.configure
end

desc 'Start the Chid app'
task :chid do
  prompt = TTY::Prompt.new(help_color: :green)		
  confirm_install = -> (action, &block) {		
    matched = /^install:(.*)/.match(action)
    return block.() unless matched

    action_name = matched.captures.first
    if  prompt.yes?("Can I install the #{action_name}?")		
      block.()		
    else		
      puts "\nNo problem. What do you need?"		
    end		
  }

  Main.new(chid_config: chid_config).init do |action, args|
    rake_task = Rake::Task[action]
    task_args = Rake::TaskArguments.new(rake_task.arg_names, args)

    confirm_install.(action) do
      rake_task.execute(task_args)
    end

    puts "\nDone! What else?"
  end
end

desc 'Open the .chid.config file'
task :chid_config do
  puts "\nOpening the .chid.config..."
  system("vim #{chid_config.chid_config_path}")
end

desc 'Show all tasks availabe'
task :help do
  Dir.chdir chid_config.chid_rake_path
  system("rake -T")
  puts "\nTell me what you need"
end

desc 'Configure default windows for development'
task :tmux_config do
  system("tmux rename-window bash")
  system("tmux new-window -n app")
  system("tmux new-window -n server")
end

desc 'Open or Create the new session for development key'
task :tmux do
  session = system('tmux attach -t development')
  unless session
    system('tmux new -s development')
  end
end

namespace :run do

  desc 'Start Postgres'
  task :postgres do
    chid_config.on_osx do
      system('postgres -D /usr/local/var/postgres')
    end
  end

end

namespace :install do

  desc 'Install RVM'
  task :rvm do
    puts "\nInstalling the RVM..."

    chid_config.on_linux do
      system('sudo apt-get install curl')
    end

    system('\curl -sSL https://get.rvm.io | bash')

    puts "\nRVM installed successfully"
  end

  desc 'Install Postgres'
  task :postgres do
    puts "\nInstalling the Postgres..."

    chid_config.on_linux do
      system('sudo apt-get install postgresql postgresql-contrib')
    end

    chid_config.on_osx do
      system('brew install postgres')
    end

    puts "\nPostgres installed successfully"
  end

  desc 'Install Node'
  task :node do
    puts "\nInstalling the Node..."

    chid_config.on_linux do
      system('sudo apt-get install nodejs')
    end

    chid_config.on_osx do
      system('brew install node')
    end

    puts "\nNode installed successfully"
  end

  desc 'Install YADR Dotfiles'
  task :dotfiles do
    puts "\nInstalling the YADR Dotfiles..."
    chid_config.on_linux do
      system('sudo apt-get install curl')
      system('sudo apt-get install zsh')
      system('sudo apt-get install git-core')
    end

    system('sh -c "`curl -fsSL https://raw.githubusercontent.com/skwp/dotfiles/master/install.sh`"')

    puts 'Updating YARD...'
    path = "#{chid_config.home_path}/.yadr/"
    Dir.chdir path
    system('git pull --rebase')
    system('rake update')

    puts "\nYARD Dotfiles installed successfully"
  end
end

namespace :currency do

  desc 'Show all types of currencies'
  task :list do
    types = CurrencyApi::SOURCES
    puts "Types available:\n\n"
    types.each { |k, v| puts "#{k} => #{v}"}
  end

  desc 'You can convert an amount between types. Ex.: convert 10 USD to BRL'
  task :convert, [:amount, :from, :to] do |t, args|
    amount = CurrencyApi.convert(args)
    puts "The converted #{args[:from]} to #{args[:to]} is: #{amount}"
  end

  desc 'Get the current conversion for USD to BRL'
  task :current do
    currency = CurrencyApi.convert()
    puts "USD is #{currency} BRL"
  end

end

desc 'List all news'
task :news do
  articles = NewsApi.articles

  articles.each do |a|
    published_at = a.publishedAt.nil? ? 'unkown' : a.publishedAt.strftime("%B %d, %Y")
    print "\n"
    print "--- #{a.title} ---".blue
    print "\n"
    print "  Posted #{published_at} by ".brown
    print "#{a.author}".green
    print "\n\n"
    print "  #{a.description}"
    print "\n\n"
    print "  Link: "
    print "#{a.url}".cyan.underline
    print "\n"
  end

  puts "\n#{NewsApi.current_page} of #{NewsApi.total_pages}"

  if NewsApi.total_pages > 1
    puts "\nPrevious(p) Next(n) Quit(q):"
    print "> "
    option = STDIN.gets
    if (/^q/.match(option))
      NewsApi.reset
    end

    if (/^n/.match(option))
      NewsApi.increase_page_by_1
      Rake::Task['news'].execute
    end

    if (/^p/.match(option))
      NewsApi.deacrease_page_by_1
      Rake::Task['news'].execute
    end
  end
end

namespace :workstation do

  desc 'List all workstations'
  task :list do
    puts "Workstations availabbe:"
    puts chid_config.all_workstations.keys
  end

  desc 'Destroy workstations'
  task :destroy do
    prompt = TTY::Prompt.new
    workstations = chid_config.all_workstations
    choices = workstations.keys
    result = prompt.multi_select('Select all workstations to destroy', choices)

    chid_config.destroy_workstations(result)
    puts "\nWorkstations removed!"
  end

  desc 'Open a specific workstation'
  task :open do
    prompt = TTY::Prompt.new
    workstations = chid_config.all_workstations
    choices = workstations.keys
    result = prompt.select('Choose a workstation to open', choices)

    puts "\nOpening all Apps"
    workstations[result.to_sym].each do |app_name|
      chid_config.on_osx do
        system("open -a '#{app_name}'")
      end

      chid_config.on_linux do
        system("#{app_name}")
      end
    end
  end

  desc 'Create a new workstation'
  task :create do
    prompt = TTY::Prompt.new

    puts 'Tell me the name of the new Workstation'
    print "> "
    workstation_name = STDIN.gets.strip

    chid_config.on_osx do
      choices = %x{ls /Applications}.strip
      choices = choices
        .gsub(/\n/, ' - ')
        .gsub('.app', '')
        .split(' - ')
      result = prompt.multi_select('Select all apps for that workstation?', choices)
      chid_config.create_workstation(workstation_name, result)
      puts "\n#{workstation_name} Workstation was created!"
    end
  end
end
