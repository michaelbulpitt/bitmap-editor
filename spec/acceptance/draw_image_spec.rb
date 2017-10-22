require_relative '../../lib/bitmap_editor'

RSpec.describe 'Drawing a bitmap image' do
  let(:expected_output_1) { "OOOOO\nOOZZZ\nAWOOO\nOWOOO\nOWOOO\nOWOOO" }
  let(:expected_output_2) { "OOOOO\nOOZZZ\nOWOOO\nOWOOO\nOWOOO\nOWOOO" }
  let(:correct_commands_file) { './spec/fixtures/correct_commands.txt' }
  let(:no_image_file) { './spec/fixtures/no_image.txt' }
  let(:invalid_file) { './spec/fixtures/invalid_file_type.csv' }
  let(:invalid_commands_file) { './spec/fixtures/invalid_commands.txt' }

  describe 'with no file specified' do
    it 'prints an error' do
      expect(STDOUT).to receive(:puts).with('File not provided')
      BitmapEditor.new.run(nil)
    end
  end

  describe 'with invalid file' do
    it 'prints an error' do
      expect(STDOUT).to receive(:puts).with('Invalid file type')
      BitmapEditor.new.run(invalid_file)
    end
  end

  describe 'with no image specified' do
    it 'prints an error' do
      expect(STDOUT).to receive(:puts).with('Please provide an image')
      BitmapEditor.new.run(no_image_file)
    end
  end

  describe 'with invalid commands' do
    it 'prints an error and the image' do
      expect(STDOUT).to receive(:puts).with('Unrecognised command')
      expect(STDOUT).to receive(:puts).with(expected_output_2)
      BitmapEditor.new.run(invalid_commands_file)
    end
  end

  describe 'with correct commands' do
    it 'prints correct bitmap' do
      expect(STDOUT).to receive(:puts).with(expected_output_1)
      BitmapEditor.new.run(correct_commands_file)
    end
  end
end