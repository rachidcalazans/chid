require 'spec_helper'

describe ::Chid::Commands::Alias::Create, '#run' do
  let(:alias_command) { ['alias', 'create'] }

  before do
    reset_bashrc(bashrc_path)
    override_bashrc_path
    invoke_run
  end

  let(:bashrc_path) { File.join(Dir.pwd, 'spec/support/.bashrc') }
  let(:override_bashrc_path) do
    allow_any_instance_of(described_class).to receive(:bashrc_path)
      .and_return(bashrc_path)
  end
  let(:invoke_run) do
    argv = alias_command
      .concat(arguments)
      .compact

    Chid::Command.run(argv)
  end

  context 'when given required arguments' do
    let(:arguments) { ['-command', 'chid workstation open', '-alias', 'cwo'] }

    it 'add alias on .bashrc' do
      last_line = last_line_at_bashrc(bashrc_path)

      expect(last_line).to eql "alias cwo='chid workstation open'"
    end

  end

  def reset_bashrc(bashrc_path)
    bash_file = File.open(bashrc_path, 'w') do |file|
      str = <<~STR
        # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
        export PATH="$PATH:$HOME/.rvm/bin"
        export TIDY_KEYS_PATH=/Users/rachidcalazans/Workspaces/tidy-workspace/pem_files
        export TIDYTOOLS_DIR=~/Workspaces/tidy-workspace/rails-workspace/ops_scripts/tidytools
        export AWS_USERNAME=rachid
        # HEY
      STR
      file.puts str
    end
  end

    def last_line_at_bashrc(bashrc_path)
      File
        .read(bashrc_path)
        .split("\n").last
    end
end
