desc 'Update Chid'
task :update do
  puts 'Updating Chid...'
  path = "#{@chid_config.chid_rake_path}"
  Dir.chdir path do |p|
    system('git pull --rebase')
  end

  @chid_config.configure

  puts "\nChid updated successfully"
end


