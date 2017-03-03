class Main

  REGEX_ACTIONS  = {
    help: [/help/, /:h/],
    news: [/news/],
    :'currency:list' => [/list/, /list currency/, /^currency/],
    :'currency:convert' => [/^conv.*\s(\d*.?\d+?)\s(\w{3})\sto\s(\w{3})/, /^currency/],
    :'currency:current' => [/current/, /^currency/, /current currency/],
    rvm: [/rvm/],
    postgres: [/postgres/, /postgre/, /postgresql/, /db/],
    dotfiles: [/dotfile/, /dotfiles/, /yard/],
    node: [/node/, /nodejs/],
    :'workstation:list' =>  [/workstation/, /work/, /list/, /list workstation/, /list work/],
    :'workstation:open' =>  [/workstation/, /work/, /open/, /open workstation/, /open work/],
    :'workstation:create' =>  [/workstation/, /work/, /create/, /create workstation/, /create work/],
    :'workstation:destroy' =>  [/workstation/, /work/, /destroy/, /destroy workstation/,
                             /destroy work/, /remove/, /remove workstation/, /remove work/]
  }


  def self.init(line)
    action   = nil
    captures_hash = {}

    actions = REGEX_ACTIONS.select do |a, regexs|
      has_action = false
      regexs.each do |r|
        matched = r.match line
        unless matched.nil?
          captures_hash[a] = matched.captures
          has_action = true
          break
        end
      end

      has_action
    end

    not_found_msgs() if actions.empty?

    if actions.count == 1
      action = actions.keys[0]
    elsif actions.count > 1
      action = choose_multiple_action(actions)
    end

    { action: action, captures: captures_hash[action] }
  end

  def self.choose_multiple_action(actions)
    puts "You are trying to execute #{actions.count} actions at once."
    puts "Please choose:"
    puts "0 - none"
    actions.each_with_index do |a, i|
      puts "#{i + 1} - #{a[0]}"
    end
    print "> "
    choose = STDIN.gets.to_i
    if choose == 0
      puts "Canceled. Let's try another command"
      return nil
    end
    choose = choose - 1
    actions.keys[choose]
  end

  def self.not_found_msgs()
    msgs = [
      "Sorry, I did not found any action.",
      "You should try another action. That does not exist. Sorry.",
      "Maybe you typed wrongly. Please try again."
    ]

    msg_number = rand(3) - 1

    puts msgs[msg_number]
  end

end
