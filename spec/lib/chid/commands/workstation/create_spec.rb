require 'spec_helper'
# @todo
# - [OK] Fix the ChidConfig.on_x for tests
# - [OK] Reset support/.chid.config with base template from Init Command or something like that
# - [OK] Refactor test code
# - [ ] Add feature to given options and arguments with workstation_name and app_names
#     - chid workstation create -name tt -apps Safari,iTerm
#     - [ ] Update test code to reuse setups and contexts
#     - [ ] Add the app_names option
#


describe ::Chid::Commands::Workstation::Create do
  describe '#run' do
    let(:invoke_run) { Chid::Command.run(argv) }
    let(:argv) do
      commands = ['workstation', 'create']
      commands.concat(options)
      commands.compact!
      commands
    end

    context 'when NOT given any options' do
      let(:options) { [] }

      context 'when the platform is osx' do
        let(:platform_name) { 'Darwin' }

        context 'when given a workstation name' do
          let(:workstation_name) { 'tt4 ' }

          context 'when choose an app' do
            let(:app_names) { %w[Safari] }

            let(:set_gets_options) do
              allow(STDIN).to receive(:gets).and_return(workstation_name)
              allow_any_instance_of(TTY::Prompt).to receive(:multi_select).and_return(app_names)
            end

            let(:chid_config)              { ::ChidConfig.new(home_base_path: "./spec/support") }
            let(:set_chid_config_instance) { allow(::ChidConfig).to receive(:new).and_return chid_config }

            let(:reset_chid_config_file) do
              template_data = {
                chid: {
                  workstations: {},
                  tmux_templates: {}
                }
              }

              File.open(chid_config.chid_config_path, 'w') do |file|
                YAML.dump(template_data, file)
              end
            end

            let(:set_plataform) do
              allow(::ChidConfig).to receive(:platform).and_return platform_name
            end

            before do
              reset_chid_config_file

              set_plataform

              set_gets_options

              set_chid_config_instance

              invoke_run
            end

            let(:load_chid_config_as_yaml) { YAML.load_file chid_config.chid_config_path }

            it 'add the new workstation name with choosen app on .chid.config file' do
              yaml_file                 = load_chid_config_as_yaml
              expected_workstation_name = :tt4
              result                    = yaml_file.dig(:chid, :workstations, expected_workstation_name)
              expected_app_names        = %w[Safari]

              expect(result).to eq expected_app_names
            end
          end
        end
      end
    end

#     - chid workstation create -name tt -apps Safari,iTerm
      #   argv = ['init', '-option_1', 'value_for_option_1']
      #
      #   map_options_with_values(argv) #=> {'-option1' => ['value_for_option_1']}
    context 'when given workstation name option' do
      let(:options) { ['-name', workstation_name] }

      context 'when the platform is osx' do
        let(:platform_name) { 'Darwin' }

        context 'when given a workstation name' do
          let(:workstation_name) { 'tt4 ' }

          context 'when choose an app' do
            let(:app_names) { %w[Safari] }

            let(:set_gets_options) do
              # allow(STDIN).to receive(:gets).and_return(workstation_name)
              allow_any_instance_of(TTY::Prompt).to receive(:multi_select).and_return(app_names)
            end

            let(:chid_config)              { ::ChidConfig.new(home_base_path: "./spec/support") }
            let(:set_chid_config_instance) { allow(::ChidConfig).to receive(:new).and_return chid_config }

            let(:reset_chid_config_file) do
              template_data = {
                chid: {
                  workstations: {},
                  tmux_templates: {}
                }
              }

              File.open(chid_config.chid_config_path, 'w') do |file|
                YAML.dump(template_data, file)
              end
            end

            let(:set_plataform) do
              allow(::ChidConfig).to receive(:platform).and_return platform_name
            end

            before do
              reset_chid_config_file

              set_plataform

              set_gets_options

              set_chid_config_instance

              invoke_run
            end

            let(:load_chid_config_as_yaml) { YAML.load_file chid_config.chid_config_path }

            it 'add the new workstation name with choosen app on .chid.config file' do
              yaml_file                 = load_chid_config_as_yaml
              expected_workstation_name = :tt4
              result                    = yaml_file.dig(:chid, :workstations, expected_workstation_name)
              expected_app_names        = %w[Safari]

              expect(result).to eq expected_app_names
            end
          end
        end
      end
    end
  end
end
