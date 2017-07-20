require 'spec_helper'

describe Chid::Commands::Init do

  subject { Chid::Commands::Init.new(chid_config_path) }

  let(:chid_config_path) { '' }

  ## TODO: Extract for a shared context test
  describe 'Documentations classes attributes' do
    it('summary should not be nil') { expect(subject.class.summary).not_to be_nil }
    it('description should not be nil') { expect(subject.class.description).not_to be_nil }
    it('arguments should be empty') { expect(subject.class.arguments).to be_empty }
  end

  describe '#run' do
    let(:chid_config_path) { File.join(File.dirname(__FILE__), '.chid.config') }
    let(:file_content_configurations) { YAML.load_file(chid_config_path) }
    let(:setup) {}

    before do
      setup
      subject.run
    end
    after  { File.delete(chid_config_path) }

    context 'When does not exist .chid.config file' do
      let(:base_configuration) do
        {
          chid: {
            workstations: {}
          }
        }
      end

      it 'Should contains the base configuration' do
        expect(file_content_configurations).to eq base_configuration
      end
    end

    context 'When does exist .chid.config file with some configuration' do
      let(:existent_configurations) do
        {
          chid: {
            workstations: {
              base: 'vim'
            }
          }
        }
      end

      let(:setup) do
        File.open(chid_config_path, 'w') do |file|
          YAML.dump(existent_configurations, file)
        end
      end

      it 'Should remains the existent configuration' do
        expect(file_content_configurations).to eq existent_configurations
      end
    end
  end

end
