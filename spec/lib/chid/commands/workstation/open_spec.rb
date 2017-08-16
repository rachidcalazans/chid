require 'spec_helper'

describe Chid::Commands::Workstation::Open, tt:true do

  subject { Chid::Commands::Workstation::Open.new(options) }

  describe '#run' do
    let(:options) { {} }
    let(:setup) {  }

    before do
      allow(subject).to receive(:open_apps)

      setup
      subject.run
    end

    context 'when no pass any argument' do
      let(:expected_workstation_name) { 'none' }

      let(:setup) do
        allow(subject).to receive(:select_workstation).and_return expected_workstation_name
      end

      it 'should call :select_workstation method' do
        expect(subject).to have_received(:select_workstation).once
      end

      it 'should call :open_apps method' do
        expect(subject).to have_received(:open_apps).with(expected_workstation_name).once
      end

    end

    context 'when pass -name as argument' do
      let(:options) { {'-name' => ['base', 'two']} }
      let(:expected_workstation_name) { 'base two' }

      let(:setup) do

      end

      it 'should call :open_apps method' do
        expect(subject).to have_received(:open_apps).with(expected_workstation_name).once
      end

    end

  end
end
