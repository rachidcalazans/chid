require 'yaml'
require 'tty-prompt'
require 'http'
require 'easy_translate'

# Require all files inside the chid folder
dir = File.join(File.dirname(__FILE__))
glob = Dir.glob(dir + "/chid/*.rb")
glob.each { |r| require r }

module Chid

  # The Regex Actions are used to execute automatically some Rake::Task
  #
  # The Keys are the name of the task
  #
  # The Values are a list of possile matchs (even Rake::TaskArguments) from a
  # typed text
  #
  # Example 1:
  #
  # :hello => [/hail/]
  #
  # That means must exist a Rake::Task called :hello and when
  # typed 'hail' the app will match with the value of the array and will execute
  # the Rake::Task[:hello]
  #
  # Example 2:
  #
  #  :'install:dotfiles' => [/install dotfiles/]
  #
  #  In that case the key has a namespace (install) and a task name (dotfiles)
  #
  #
  # If you want to pass some argument you can use the Capture Enclosed option on
  # regex.
  #
  # Example 3:
  #
  # :hello => [/hail\s(.*)/]
  #
  # That means the captured arguments to use on Rake::Task is inside the '()'. In
  # that case any characteres typed after 'hail ' will be used as Rake::TaskArguments

  REGEX_ACTIONS  = {
    :help                  => [/help/, /:h/],
    :chid_config           => [/config.*/, /chid config.*/],
    :news                  => [/news/],
    :'currency:list'       => [/^list$/, /^list currency$/, /^currency$/, /^currency list$/],
    :'currency:convert'    => [/^conv.*\s(\d*.?\d+?)\s(\w{3})\sto\s(\w{3})/, /^currency/],
    :'currency:current'    => [/current/, /^currency/, /current currency/],
    :'install:rvm'         => [/install rvm/],
    :'install:postgres'    => [/install postgres/],
    :'install:dotfiles'    => [/install dotfile/, /install dotfiles/, /install yard/],
    :'install:node'        => [/install node/],
    :'run:postgres'        => [/run postgres/],
    :'workstation:list'    => [/^workstation/, /^work$/, /^list$/, /^list workstation$/, /^list work$/, /^work list$/],
    :'workstation:open'    => [/^workstation/, /^work$/, /^work open$/, /^open workstation/, /^open work$/,
                               /^open work\s(.+)/, /^open\s(.+)/, /^work open\s(.+)/],
    :'workstation:create'  => [/^workstation/, /^work$/, /create/, /create workstation/, /create work/],
    :'workstation:destroy' => [/^workstation/, /^work$/, /destroy/, /destroy workstation/,
                               /destroy work/, /remove/, /remove workstation/, /remove work/],
    :'update:os'           => [/update os/, /update/],
    :'stack'               => [/^stack\s(.*)/, /^stack/],
    :'translate:yandex_translate' => [/^t\s(.*)\s(\w{2})\sto\s(\w{2})/, /^t\s(.*)/ ],
    :'translate:yandex_list' => [/^translate list/ ],
    :github                 => [/^github\s(.+)/]
  }


end

# Add styles for String class
class String
  def black;          "\e[30m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def gray;           "\e[37m#{self}\e[0m" end

  def bg_black;       "\e[40m#{self}\e[0m" end
  def bg_red;         "\e[41m#{self}\e[0m" end
  def bg_green;       "\e[42m#{self}\e[0m" end
  def bg_brown;       "\e[43m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end
  def bg_magenta;     "\e[45m#{self}\e[0m" end
  def bg_cyan;        "\e[46m#{self}\e[0m" end
  def bg_gray;        "\e[47m#{self}\e[0m" end

  def bold;           "\e[1m#{self}\e[22m" end
  def italic;         "\e[3m#{self}\e[23m" end
  def underline;      "\e[4m#{self}\e[24m" end
  def blink;          "\e[5m#{self}\e[25m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
end


