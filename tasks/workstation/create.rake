namespace :workstation do

  desc 'Create a new workstation'
  task :create do
    prompt = TTY::Prompt.new

    puts 'Tell me the name of the new Workstation'
    print "> "
    workstation_name = STDIN.gets.strip

    @chid_config.on_osx do
      choices = %x{ls /Applications}.strip
      choices = choices
        .gsub(/\n/, ' - ')
        .gsub('.app', '')
        .split(' - ')
      result = prompt.multi_select('Select all apps for that workstation?', choices)
      @chid_config.create_workstation(workstation_name, result)
      puts "\n#{workstation_name} Workstation was created!"
    end
  end

end
