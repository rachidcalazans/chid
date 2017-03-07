class Main

  REGEX_ACTIONS  = {
    help: [/help/, /:h/],
    chid_config: [/config.*/, /chid config.*/],
    news: [/news/],
    :'currency:list'       => [/^list$/, /^list currency$/, /^currency$/],
    :'currency:convert'    => [/^conv.*\s(\d*.?\d+?)\s(\w{3})\sto\s(\w{3})/, /^currency/],
    :'currency:current'    => [/current/, /^currency/, /current currency/],
    :'install:rvm'         => [/rvm/],
    :'install:postgres'    => [/postgres/, /postgre/, /postgresql/, /db/],
    :'install:dotfiles'    => [/dotfile/, /dotfiles/, /yard/],
    :'install:node'        => [/node/, /nodejs/],
    :'workstation:list'    => [/^workstation/, /^work$/, /^list$/, /^list workstation$/, /^list work$/, /^work list$/],
    :'workstation:open'    => [/^workstation/, /^work$/, /^open$/, /^open workstation/, /^open work$/,
                               /^open work\s(.+)/, /^open\s(.+)/, /^work open\s(.+)/],
    :'workstation:create'  => [/^workstation/, /^work$/, /create/, /create workstation/, /create work/],
    :'workstation:destroy' => [/^workstation/, /^work$/, /destroy/, /destroy workstation/,
                               /destroy work/, /remove/, /remove workstation/, /remove work/],
    :'update:os' => [/update os/, /update/]
  }

  ActionWithArgs = Struct.new(:action, :args)

  private
  attr_reader :chid_config

  public
  def initialize(chid_config)
    @chid_config = chid_config
  end

  def init(&execute_action_block)
    puts "Hello #{chid_config.username}"
    msg = "How can I help you?"

    run(&execute_action_block)
  end

  private
  def fn_get_input
    -> () {
      print "> "
      STDIN.gets.strip
    }
  end

  def run(&execute_action_block)
    input = fn_get_input.()
    if quit_command?(input)
      puts 'Bye Bye'
      return
    end
    get_action(input, &execute_action_block)
    run(&execute_action_block)
  end

  def quit_command?(input)
    input =~ /^:q/ || input =~ /^bye/ || input =~ /^quit/ || input =~ /^exit/
  end

  def get_action(input, &execute_action_block)
    actions_with_args = get_actions_with_args(input)
    return not_found_msgs if actions_with_args.empty?

    get_action_with_args(actions_with_args) do | action_with_args|
      execute_action_block.(action_with_args.action, action_with_args.args)
    end

  end

  def get_actions_with_args(input)
    actions_with_args = REGEX_ACTIONS.collect do |action, regexs|
      action_with_args = nil

      regex_match(input, regexs) do |captured_args|
        action_with_args  = ActionWithArgs.new(action, captured_args)
      end
      action_with_args
    end.compact!
  end

  def regex_match(input, regexs, &block)
    regexs.each do |regex|
      matched = regex.match input
      if matched
        captured_args = matched.captures
        block.(captured_args)
        return
      end
    end
  end

  def get_action_with_args(actions_with_args)
    return if actions_with_args.nil?

    if actions_with_args.count > 1
      action_with_args = choose_multiple_action(actions_with_args)
    else
      action_with_args = actions_with_args.first
    end

    yield action_with_args if action_with_args
  end

  def choose_multiple_action(actions_with_args)
    puts "You are trying to execute #{actions_with_args.count} actions at once."
    puts "Please choose:"
    puts "0 - none"
    actions_with_args.each_with_index { |a, i| puts "#{i + 1} - #{a.action}" }
    choose = fn_get_input.().to_i
    if choose == 0
      puts "Ok, canceled"
      return nil
    end
    choose = choose - 1
    actions_with_args[choose]
  end

  def not_found_msgs()
    msgs = [
      "Sorry, I did not found any action.",
      "You should try another action. That does not exist. Sorry.",
      "Maybe you typed wrongly. Please try again."
    ]

    msg_number = rand(3) - 1

    puts msgs[msg_number]
  end

end
