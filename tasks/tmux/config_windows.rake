desc 'Configure default windows for development'
task :tmux_config do
  system("tmux rename-window bash")
  system("tmux new-window -n app")
  system("tmux new-window -n server")
end


