require_relative '../../../lib/input/text_file'

RSpec.describe Input::TextFile do
  subject { described_class.new(file: file) }
  let(:file) { './spec/fixtures/correct_commands.txt' }
  let(:expected_output) { ['I 5 6', 'L 1 3 A', 'V 2 3 6 W', 'H 3 5 2 Z', 'S'] }

  describe '#parse' do
    it 'parses file' do
      expect(subject.parse).to eq(expected_output)
    end
  end
end
