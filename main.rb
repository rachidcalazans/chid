class Main

  REGEX_ACTIONS  = {
    help: [/help/, /:h/],
    news: [/news/],
    currency: [/currency/, /current currency/],
    convert: [/convert/],
    rvm: [/rvm/],
    postgres: [/postgres/, /postgre/, /postgresql/, /db/],
    dotfiles: [/dotfile/, /dotfiles/, /yard/],
    node: [/node/, /nodejs/],
    workstation: [/workstation/, /work/]
  }


  def self.init(line)
    action = nil
    actions = REGEX_ACTIONS.select do |a, regexs|
      has_action = false
      regexs.each do |r|
        matched = r.match line
        unless matched.nil?
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

    action

  end

  def self.choose_multiple_action(actions)
    puts "You are trying to execute #{actions.count} actions at once."
    puts "Please choose:"
    actions.each_with_index do |a, i|
      puts "#{i + 1} - #{a[0]}"
    end
    print "> "
    choose = STDIN.gets
    choose = choose.to_i - 1
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
