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
  #r = %x{find ~/ -name ".chid.config"}.strip
  print  "Configurating the Chid app...\n\n"

  chid_config.configure

  print "Configuration done!\n\n"

  print "Chid is an assistant to help your day-to-day life. It can be used in some installations, news, etc.\n\n"
  print "You can use it without starting the app through Rake Tasks or as an app, having a greater interaction with it.\n\n"

  print "To initialize the app you can run the command: "
  print "$ rake\n".blue
  print "Or the command: "
  print "$ chid\n".blue
  print "But for the "
  print "$ chid ".blue
  print "command works you must reload your .bashrc\n\n"

  print "To reload your .bashrc you can run: "
  print "source #{chid_config.home_path}.bashrc".blue

  #print "\n\nInitializing the chid app..\n\n"
  #Rake::Task['chid'].execute
end

desc 'Start the Chid app'
task :chid do
  puts "Hello #{chid_config.username}"
  puts "\nHow can I help you?"

  loop do
    print "> "
    line = STDIN.gets
    if line =~ /^:q/ || line =~ /^bye/ || line =~ /^quit/ || line =~ /^exit/
      puts "Bye Bye"
      break
    end

    result = Main.init(line)

    action   = result[:action]
    captures = result[:captures]

    if (action == :news)
      Rake::Task['news'].execute
      puts "\nDone! Something else?"
    end

    if (action == :'currency:list')
      Rake::Task['currency:list'].execute
      puts "\nDone! Something else?"
    end

    if (action == :'currency:current')
      Rake::Task['currency:current'].execute
      puts "\nDone! Something else?"
    end

    if (action == :'currency:convert')
      amount, from, to = captures
      options = {amount: amount, from: from, to: to}
      Rake::Task['currency:convert'].execute(options)
      puts "\nDone! Something else?"
    end

    if (action == :rvm)
      Rake::Task['install:rvm'].execute
      puts "\nRVM installed! Something else?"
    end

    if (action == :postgres)
      Rake::Task['install:postgres'].execute
      puts "\nPostgres installed! Something else?"
    end

    if (action == :node)
      Rake::Task['install:node'].execute
      puts "\nNode installed! Something else?"
    end

    if (action == :dotfiles)
      Rake::Task['install:dotfiles'].execute
      puts "\nDotfiles installed! Something else?"
    end

    if (action == :'workstation:list')
      Rake::Task['workstation:list'].execute
      puts "\nSomething else?"
    end

    if (action == :'workstation:open')
      Rake::Task['workstation:open'].execute
      puts "\nSomething else?"
    end

    if (action == :'workstation:create')
      Rake::Task['workstation:create'].execute
      puts "\nSomething else?"
    end

    if (action == :'workstation:destroy')
      Rake::Task['workstation:destroy'].execute
      puts "\nSomething else?"
    end

    if (action == :help)
      puts "I can help you with:"
      puts "  - news        -> List all news on web"
      puts "  - currency    -> Show the current currency for USD to BRL"
      puts "  - convert     -> Convert some amount from USD to BRL"
      puts "  - rvm         -> Installing the RVM"
      puts "  - postgres    -> Installing and Run the Postgres"
      puts "  - node        -> Installing the Node"
      puts "  - dotfiles    -> Installing the YARD Dotfiles"
      puts "  - workstation -> Open all application you use every day"
      puts "\nTell me what you need"
    end

  end

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
  desc 'Start Postgres for OSx'
  task :postgres do
    system('postgres -D /usr/local/var/postgres')
  end

end

namespace :install do

  desc 'Install RVM'
  task :rvm do

    config.on_linux do
      system('sudo apt-get install curl')
    end

    system('\curl -sSL https://get.rvm.io | bash')

  end

  desc 'Install Postgres'
  task :postgres do
    chid_config.on_linux do
      system('sudo apt-get install postgresql postgresql-contrib')
    end

    chid_config.on_osx do
      system('brew install postgres')
    end
  end

  desc 'Install Node'
  task :node do
    chid_config.on_linux do
      system('sudo apt-get install nodejs')
    end

    chid_config.on_osx do
      system('brew install node')
    end
  end

  desc 'Install YADR Dotfiles'
  task :dotfiles do
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
    currency = CurrencyApi.convert(args)
    puts "The converted #{args[:from]} to #{args[:to]} is: #{currency}"
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

  #articles.select { |a| /ruby/.match(a.title) }
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
