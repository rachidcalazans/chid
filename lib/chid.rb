require 'yaml'
require 'tty-prompt'
require 'http'
require 'zlib'
require 'stringio'

require_relative 'chid/chid_config'
require_relative 'chid/main'
require_relative 'chid/currency_api'
require_relative 'chid/news_api'
require_relative 'chid/stack_overflow_api'

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
  # If you want to pass some argument you can use the Capture Enclosed option on
  # regex.
  #
  # Example 2:
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
    :'update:os'            => [/update os/, /update/],
    :'stack'                => [/^stack\s(.*)/, /^stack/]
  }

end
