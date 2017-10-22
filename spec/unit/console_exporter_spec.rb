require_relative '../../lib/console_exporter'

RSpec.describe ConsoleExporter do
  subject { described_class.new(bitmap: bitmap) }
  let(:bitmap) do
    [
      %w[O O O O O],
      %w[O D D D O],
      %w[W O O O O],
      %w[W O B A O],
      %w[O O O O O]
    ]
  end

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
