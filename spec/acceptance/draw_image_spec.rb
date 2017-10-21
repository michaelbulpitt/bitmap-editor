require_relative '../../lib/bitmap_editor'

RSpec.describe 'Drawing a bitmap image' do
  let(:expected_output_1) {
    "OOOOO\nOOZZZ\nAWOOO\nOWOOO\nOWOOO\nOWOOO"
  }
  let(:correct_commands_file) { './spec/fixtures/correct_commands.txt' }
  let(:invalid_commands_file) { './spec/fixtures/invalid_commands.txt' }

  describe 'with no file specified' do
    it 'prints an error' do
      expect(STDOUT).to receive(:puts).with('Please provide a correct file')
      BitmapEditor.new.run(nil)
    end
  end

  describe 'with correct commands' do
    it 'prints correct bitmap' do
      expect(STDOUT).to receive(:puts).with(expected_output_1)
      BitmapEditor.new.run(correct_commands_file)
    end
  end

  describe 'with invalid first command' do
    it 'prints an error' do
      expect(STDOUT).to receive(:puts).with('Not a valid file')
      BitmapEditor.new.run(invalid_commands_file)
    end
  end

end