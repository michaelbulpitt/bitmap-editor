require_relative '../../lib/bitmap_processor'

RSpec.describe BitmapProcessor do
  subject { described_class.new(commands: commands) }
  let(:commands) { ['I 5 5', 'D 2 3 A'] }

  describe '#process' do
    context 'with valid commands' do
      it 'receives the correct commands' do
        expect(subject).to receive(:process_command).twice
        subject.process
      end
    end

    context 'with no commands' do
      let(:commands) { nil }

      it 'raises RuntimeError' do
        expect { subject.process }.to raise_error(RuntimeError, 'No commands found')
      end
    end

    context 'with empty commands' do
      let(:commands) { [] }

      it 'raises RuntimeError' do
        expect { subject.process }.to raise_error(RuntimeError, 'No commands found')
      end
    end
  end

  describe '#process_command' do
    let(:bitmap) { nil }
    before do
      allow(subject).to receive(:bitmap) { bitmap }
    end

    context 'invalid command' do
      let(:command) { 'INVALID COMMAND' }

      it 'outputs error' do
        expect(STDOUT).to receive(:puts).with('Unrecognised command')
        subject.process_command(command)
      end
    end

    context 'with no image specified first' do
      let(:command) { 'L 1 3 A' }

      it 'raises error' do
        expect { subject.process_command(command) }.to raise_error(RuntimeError, 'Please provide an image')
      end
    end

    context 'image creation command' do
      let(:command) { 'I 5 6' }

      it 'creates a new Bitmap class with correct args' do
        expect(Bitmap).to receive(:new).with(width: '5', height: '6')
        subject.process_command(command)
      end
    end

    context 'colour pixel command' do
      let(:command) { 'L 1 3 A' }
      let(:bitmap) { Bitmap.new(width: 5, height: 5) }

      it 'calls colour_pixel command with correct args' do
        expect(bitmap).to receive(:colour_pixel).with(column: '1', row: '3', colour: 'A')
        subject.process_command(command)
      end
    end

    context 'reset bitmap command' do
      let(:command) { 'C' }
      let(:bitmap) { Bitmap.new(width: 5, height: 5) }

      it 'calls colour_pixel command with correct args' do
        expect(bitmap).to receive(:reset) { true }
        subject.process_command(command)
      end
    end

    context 'colour column command' do
      let(:command) { 'V 2 3 6 W' }
      let(:bitmap) { Bitmap.new(width: 5, height: 5) }

      it 'calls colour_column command with correct args' do
        expect(bitmap).to receive(:colour_column).with(column: '2', start_row: '3', end_row: '6', colour: 'W')
        subject.process_command(command)
      end
    end

    context 'colour row command' do
      let(:command) { 'H 3 5 2 Z' }
      let(:bitmap) { Bitmap.new(width: 5, height: 5) }

      it 'calls colour_row command with correct args' do
        expect(bitmap).to receive(:colour_row).with(start_column: '3', end_column: '5', row: '2', colour: 'Z')
        subject.process_command(command)
      end
    end

    context 'print image command' do
      let(:command) { 'S' }

      context 'with no image to print' do
        it 'raises RuntimeError' do
          expect { subject.process_command(command) }.to raise_error(RuntimeError, 'No image to print')
        end
      end

      context 'with image to print' do
        let(:bitmap) { Bitmap.new(width: 5, height: 5) }
        let(:export_process) { double }

        it 'runs exporter processor' do
          expect(ConsoleExporter).to receive(:new).with(bitmap: bitmap.pixels) { export_process }
          expect(export_process).to receive(:process) { true }
          subject.process_command(command)
        end
      end
    end
  end
end
