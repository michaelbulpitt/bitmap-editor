require_relative '../../lib/bitmap'

RSpec.describe Bitmap do
  subject { described_class }

  describe 'creation' do
    context 'wrong arguments provided' do
      it 'throws ArgumentError' do
        expect { subject.new() }.to raise_error(ArgumentError)
      end
    end

    context 'with valid dimensions' do
      subject { described_class.new(width: 5, height: 5) }
      let(:expected_bitmap) do
        [
          ['O', 'O', 'O', 'O', 'O'],
          ['O', 'O', 'O', 'O', 'O'],
          ['O', 'O', 'O', 'O', 'O'],
          ['O', 'O', 'O', 'O', 'O'],
          ['O', 'O', 'O', 'O', 'O']
        ]
      end

      it 'creates a blank bitmap with correct dimensions' do
        expect(subject.pixels).to eq(expected_bitmap)
      end
    end
  end

  describe '#colour_pixel' do
    subject { Bitmap.new(width: 5, height: 5) }

    context 'with valid pixel coordinate' do
      it 'colours correct pixel' do
        subject.colour_pixel(column: 1, row: 3, colour: 'D')
        expect(subject.pixels).to eq(
          [
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O'],
            ['D', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O']
          ]
        )
      end
    end

    context 'with invalid pixel coordinate' do
      it 'does not colour pixel' do
        subject.colour_pixel(column: 6, row: 1, colour: 'D')
        expect(subject.pixels).to eq(
          [
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O']
          ]
        )
      end
    end
  end

  describe '#colour_column' do
    subject { described_class.new(width: 5, height: 5) }

    context 'with valid pixel coordinate' do
      it 'colours correct pixel' do
        subject.colour_column(column: 2, start_row: 2, end_row: 5, colour: 'D')
        expect(subject.pixels).to eq(
          [
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'D', 'O', 'O', 'O'],
            ['O', 'D', 'O', 'O', 'O'],
            ['O', 'D', 'O', 'O', 'O'],
            ['O', 'D', 'O', 'O', 'O']
          ]
        )
      end
    end

    context 'with invalid pixel coordinate' do
      it 'does not colour pixels' do
        subject.colour_column(column: 2, start_row: 2, end_row: 7, colour: 'D')
        expect(subject.pixels).to eq(
          [
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O']
          ]
        )
      end
    end
  end

  describe '#colour_row' do
    subject { described_class.new(width: 5, height: 5) }

    context 'with valid pixel coordinate' do
      it 'colours correct pixel' do
        subject.colour_row(start_column: 2, end_column: 4, row: 2, colour: 'D')
        expect(subject.pixels).to eq(
          [
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'D', 'D', 'D', 'O'],
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O']
          ]
        )
      end
    end

    context 'with invalid pixel coordinate' do
      it 'does not colour pixels' do
        subject.colour_row(start_column: 1, end_column: 10, row: 2, colour: 'D')
        expect(subject.pixels).to eq(
          [
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O'],
            ['O', 'O', 'O', 'O', 'O']
          ]
        )
      end
    end
  end
end