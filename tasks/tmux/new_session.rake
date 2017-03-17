desc 'Open or Create the new session for development key'
task :tmux do
  session = system('tmux attach -t development')
  unless session
    system('tmux new -s development')
  end
end


