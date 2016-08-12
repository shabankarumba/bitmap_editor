require './lib/bitmap_validator'

RSpec.describe BitmapValidator do
  describe '#valid?' do
    context 'when the conditions are valid' do
      subject { described_class.new(250, 250) }

      it 'outputs true' do
        expect(subject.valid?).to eq(true)
      end
    end

    context 'when something is invalid' do
      subject { described_class.new(251, 251) }

      it 'outputs false' do
        expect(subject.valid?).to eq(false)
      end
    end
  end
end
