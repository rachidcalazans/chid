require 'spec_helper'

describe Chid::Command do

  let(:subject_class) { Chid::Command }

  describe '.run' do

    context 'When no pass any command' do
      let(:argv) { options }

      let(:setup_allows) { allow(subject_class).to receive(:help) }

      before do
        setup_allows
        Chid::Command.run(argv)
      end

      context 'When pass :helper option' do
        let(:options) { ['-h'] }

        it 'Should call :help method' do
          expect(subject_class).to have_received(:help)
        end
      end

      context 'When pass invalid option' do
        let(:options) { ['-invalid_option'] }

        it 'Should call :help method' do
          expect(subject_class).to have_received(:help)
          end
      end

    end

    context 'When pass an invalid command' do
      let(:command) { 'invalid_command' }
      let(:options) { [] }
      let(:argv) { [command].concat(options) }

      let(:setup_allows) { allow(subject_class).to receive(:help) }

      before do
        setup_allows
        Chid::Command.run(argv)
      end

      it 'Should call :help method' do
        expect(subject_class).to have_received(:help)
      end
    end

    context 'When pass a valid command' do
      let(:init_command_class) { double arguments: [] }
      let(:init_command)       { double class: init_command_class }

      let(:command) { 'init' }
      let(:options) { [] }
      let(:argv) { [command].concat(options) }

      let(:default_allows) do
        allow(subject_class).to receive(:command_key_is_included?).and_return(true)
        allow(subject_class).to receive(:new_command_instance).and_return(init_command)
      end

      let(:setup_allows) { allow(init_command_class).to receive(:help) }

      before do
        default_allows
        setup_allows
        Chid::Command.run(argv)
      end

      # @TODO: Extract that context to shared examples
      context 'When pass :help options' do
        let(:options) { ['-h'] }

        it 'Command should call :help method' do
          expect(init_command_class).to have_received(:help)
        end
      end

      context 'When pass invalid options' do
        let(:options) { ['-ah', 'some', 'value'] }

        it 'Should call :help method' do
          expect(init_command_class).to have_received(:help)
        end
      end

      context 'When pass valid options' do
        let(:options) { ['-some_valid_option', 'some', 'value'] }

        let(:setup_allows) do
          allow(init_command).to receive(:run)
          allow(subject_class).to receive(:has_valid_arguments?).and_return(true)
        end

        it 'Command should call :new method with :options' do
          expected_options = {
            '-some_valid_option' => ['some', 'value']
          }
          expect(subject_class).to have_received(:new_command_instance).with(:init, expected_options)
        end

        it 'Command should call :run method' do
          expect(init_command).to have_received(:run)
        end

      end

    end
  end
end
