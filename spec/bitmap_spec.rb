require 'spec_helper'
require 'bitmap'

RSpec.describe Bitmap do
  subject { described_class.new(3, 3) }
  describe '.new' do
    it 'creates an empty bitmap' do
      expect(subject.show_map).to eq(
        [%w(O O O),
         %w(O O O),
         %w(O O O)]
      )
    end
  end

  describe '#color_pixel' do
    context 'when the pixel exists' do
      it 'changes the color of the pixel' do
        subject.color_pixel(2, 3, 'X')

        expect(subject.show_map).to eq(
          [%w(O O O),
           %w(O O O),
           %w(O X O)]
        )
      end
    end

    context 'when the column does not exist' do
      it 'outputs an error message' do
        expect(STDOUT).to receive(:puts).with(
          'Please enter a color and column/row number which exists in the map,
as you entered the following arguments color: X,
column number: 4 and row number: 3
'
        )

        subject.color_pixel(4, 3, 'X')
      end
    end

    context 'when the row does not exist' do
      it 'outputs an error message' do
        expect(STDOUT).to receive(:puts).with(
          'Please enter a color and column/row number which exists in the map,
as you entered the following arguments color: X,
column number: 3 and row number: 4
'
        )

        subject.color_pixel(3, 4, 'X')
      end
    end
  end

  describe '#color_pixels_vertically' do
    it 'changes the color of pixels vertically' do
      expect(subject.color_pixels_vertically(2, 1, 2, 'X')).to eq(
        [%w(O X O),
         %w(O X O),
         %w(O O O)]
      )
    end
  end

  describe '#color_pixels_horizontally' do
    it 'changes the color of pixels horizontally' do
      expect(subject.color_pixels_horizontally(1, 3, 2, 'X')).to eq(
        [%w(O O O),
         %w(X X X),
         %w(O O O)]
      )
    end
  end

  describe '#show_map' do
    it 'shows a formatted map' do
      expect(STDOUT).to receive(:puts).with('O O O').thrice

      subject.show_map
    end
  end
end
