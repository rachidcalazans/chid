require 'spec_helper'
# @todo
# - [OK] Fix the ChidConfig.on_x for tests
# - [OK] Reset support/.chid.config with base template from Init Command or something like that
# - [OK] Refactor test code
# - [ ] Add feature to given options and arguments with workstation_name and app_names
#     - chid workstation create -name tt -app_names Safari,iTerm
#     - [OK] Update test code to reuse setups and contexts
#     - [OK] Add the app_names option
#     - [ ] Fix Bug when the workstation_name has `-`. Eg.: -name tt-maris
#     - [ ] Fix Bug when the app_names has empty space. Eg.: -name ttmaris -app_names AdBlock Alfred 4
#           - It works when the app_name with space use ''. Eg.: -name ttmaris -app_names AdBlock 'Alfred 4'
#

describe ::Chid::Commands::Workstation::Create do
  describe '#run' do
    before do
      reset_chid_config_file

      set_chid_config_instance

      set_plataform

      set_get_option

      set_multi_select_option

      invoke_run
    end
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
    let(:set_get_option)           { allow(STDIN).to receive(:gets).and_return(workstation_name) }
    let(:set_multi_select_option)  { allow_any_instance_of(TTY::Prompt).to receive(:multi_select).and_return(app_names) }
    let(:set_chid_config_instance) { allow(::ChidConfig).to receive(:new).and_return chid_config }
    let(:set_plataform)            { allow(::ChidConfig).to receive(:platform).and_return platform_name }

    let(:invoke_run) do
      argv = ['workstation', 'create']
      argv.concat(options)
      argv.compact!

      Chid::Command.run(argv)
    end

    let(:chid_config)              { ::ChidConfig.new(home_base_path: "./spec/support") }
    let(:load_chid_config_as_yaml) { YAML.load_file chid_config.chid_config_path }

    context 'when given a workstation name' do
      let(:workstation_name) { 'tt5' }

      context 'when choose an app' do
        let(:app_names) { %w[Safari] }

        context 'when NOT given any options' do
          let(:options) { [] }

          context 'when the platform is osx' do
            let(:platform_name) { 'Darwin' }

            it 'add the new workstation name with choosen app on .chid.config file' do
              yaml_file = load_chid_config_as_yaml
              result    = yaml_file.dig(:chid, :workstations, :tt5)

              expect(result).to eq %w[Safari]
            end
          end
        end

        context 'when given workstation name option' do
          let(:options) { ['-name', workstation_name] }

          context 'when the platform is osx' do
            let(:platform_name) { 'Darwin' }

            it 'add the new workstation name with choosen app on .chid.config file' do
              yaml_file = load_chid_config_as_yaml
              result    = yaml_file.dig(:chid, :workstations, :tt5)

              expect(result).to eq %w[Safari]
            end

            context 'when given app_names option' do
              let(:app_names) { %w[Safari iTerm] }
              let(:options)   { ['-name', workstation_name, '-app_names'].concat(app_names) }
              let(:set_multi_select_option) do
                ask_msg = 'select all apps for that workstation?'
                os_app_names = ['1Password 7', 'Accelerate', 'Safari', 'iTerm']

                allow_any_instance_of(::Chid::Commands::Workstation::Create).to receive(:osx_application_names).and_return [os_app_names]

                allow_any_instance_of(TTY::Prompt).to receive(:multi_select)
                  .with(ask_msg, [os_app_names], default: [3,4])
                  .and_return(app_names)
              end

              it 'add all new options on .chid.config file' do
                yaml_file = load_chid_config_as_yaml
                result    = yaml_file.dig(:chid, :workstations, :tt5)

                expect(result).to eq %w[Safari iTerm]
              end
            end
          end
        end
      end
    end
  end
end
