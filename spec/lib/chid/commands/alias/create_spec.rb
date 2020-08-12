require 'spec_helper'

describe ::Chid::Commands::Alias::Create, '#run' do
  let(:invoke_run) do
    argv = ['alias', 'create']
    argv.concat(options)
    argv.compact!

    Chid::Command.run(argv)
  end

  before do
    reset_bashrc

    allow_any_instance_of(described_class).to receive(:bashrc_path)
      .and_return(bashrc_path)

    invoke_run
  end
  let(:bashrc_path) { File.join(Dir.pwd, 'spec/support/.bashrc') }

  context 'when given required arguments' do
    let(:options) { ['-command', 'chid workstation open', '-alias', 'cwo'] }

    it 'add alias on .bashrc' do
      bash_file = File.read(bashrc_path)
      last_line = bash_file.split("\n").last

      expect(last_line).to eql "alias cwo='chid workstation open'"
      expect(invoke_run).to be == true
    end
  end

  def reset_bashrc
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
end
