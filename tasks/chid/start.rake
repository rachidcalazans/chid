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

  Main.new(@chid_config).init do |action, args|
    rake_task = Rake::Task[action]
    task_args = Rake::TaskArguments.new(rake_task.arg_names, args)

    confirm_install.(action) do
      rake_task.execute(task_args)
    end

    puts "\nDone! What else?"
  end
end
