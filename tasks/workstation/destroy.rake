namespace :workstation do

  desc 'Destroy workstations'
  task :destroy do
    prompt = TTY::Prompt.new
    workstations = @chid_config.all_workstations
    choices = workstations.keys
    result = prompt.multi_select('Select all workstations to destroy', choices)

    @chid_config.destroy_workstations(result)
    puts "\nWorkstations removed!"
  end

end
