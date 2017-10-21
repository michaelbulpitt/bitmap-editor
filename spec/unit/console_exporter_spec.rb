require_relative '../../lib/console_exporter'

RSpec.describe ConsoleExporter do
  subject { described_class.new(bitmap: bitmap) }
  let(:bitmap) {
    [
      ['O', 'O', 'O', 'O', 'O'],
      ['O', 'D', 'D', 'D', 'O'],
      ['W', 'O', 'O', 'O', 'O'],
      ['W', 'O', 'B', 'A', 'O'],
      ['O', 'O', 'O', 'O', 'O']
    ]
  }

  describe '#process' do
    context 'valid bitmap' do

      it 'logs bitmap in correct format' do
        expect(STDOUT).to receive(:puts). with("OOOOO\nODDDO\nWOOOO\nWOBAO\nOOOOO")
        subject.process
      end
    end

    context 'no bitmap' do
      let(:bitmap) { nil }

      it 'returns false' do
        expect(subject.process).to be_falsey
      end
    end
  end
end