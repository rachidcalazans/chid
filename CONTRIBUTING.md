# Contrinuting to Chid

## How run chid gem locally
`$ ruby -Ilib bin/chid [COMMAND]`

## Adding a new Command

### When the command has no sub-command
An example of no sub-command is the `chid news` command. 

This command is straightforward, execute the `news` command.
### When the command has sub-command
An example of no sub-command is the `chid workstation` command. 

For this command we have the following sub-commands:
- `create`
- `destroy`
- `list`
- `open`

A usage for it is `chid workstation open`

#### Structure
As we need many sub-commands, is necessary create a new module (folder) inside the `./lib/chid/commands/` folder.

For example we want to add `currency` with follwing commands:
- `current`
- `convert`
- `list`

The first thing is create the folder with those sub-commands:
- `./lib/chid/commands/currency/current.rb`
- `./lib/chid/commands/currency/convert.rb`
- `./lib/chid/commands/currency/list.rb`

**Class structure**: 

This initial structure must exists to follow the command pattern to work on chid. The structure will be automatically added on helper command, when the user calls for example `chid currency now -h`

```ruby
# ./lib/chid/commands/currency/current.rb

module Chid
  module Commands
    module Currency
      class Now < Command

        command :'currency current' # COMMAND_NAME

        self.summary = 'Summary of your new Command'
        self.description = <<-DESC

Usage:

  $ chid currency now

    SOME_DESCRIPTION_OF_THE_COMMAND


Options: # These are not required, only if your command demands for options.

  -to TEXT_TO_EXPLAIN
  -from TEXT_TO_EXPLAIN

      DESC
      self.arguments = ['-to', '-from']


		# This method will be executed automatically
		# To access all given arguments, you have available the attr_reader :options to get
        def run
        end

      end
    end
  end
end
```
