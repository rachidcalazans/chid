namespace :workstation do

  desc 'Open a specific workstation'
  task :open, [:workstation] do |t, args|
    workstations = @chid_config.all_workstations

    workstation_name = args[:workstation]
    apps = workstations[workstation_name.to_sym] unless workstation_name.nil?

    if apps.nil?
      prompt = TTY::Prompt.new
      choices = workstations.keys
      result = prompt.select('Choose a workstation to open', choices)
      apps = workstations[result.to_sym]
    end

    puts "\nOpening all Apps"
    apps.each do |app_name|
      @chid_config.on_osx do
        system("open -a #{app_name}")
      end

      @chid_config.on_linux do
        system("#{app_name} >/dev/null 2>&1 &")
      end
    end
  end

end
