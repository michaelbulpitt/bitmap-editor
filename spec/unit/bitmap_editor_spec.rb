require_relative '../../lib/bitmap_editor'

RSpec.describe BitmapEditor do
  subject { described_class }
  let(:file) { './spec/fixtures/correct_commands.txt' }

  describe '#run' do
    context 'with valid file' do
      let(:file_processor) { double(parse: ['D 4 5']) }
      let(:bitmap_processor) { double }

      it 'processes file' do
        expect(Input::Processor).to receive(:new).with(file: file) { file_processor }
        expect(BitmapProcessor).to receive(:new).with(commands: file_processor.parse) { bitmap_processor }
        expect(bitmap_processor).to receive(:process) { true }
        subject.new.run(file)
      end
    end

    context 'with no file' do
      let(:file) { nil }

      it 'raises error' do
        expect(STDOUT).to receive(:puts).with('File not provided')
        subject.new.run(file)
      end
    end

    context 'with invalid file type' do
      let(:file) { './spec/fixtures/invalid_file_type.csv' }

      it 'raises error' do
        expect(STDOUT).to receive(:puts).with('Invalid file type')
        subject.new.run(file)
      end
    end
  end
end