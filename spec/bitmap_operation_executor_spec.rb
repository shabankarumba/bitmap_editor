require 'spec_helper'
require './lib/bitmap_operation_executor'

RSpec.describe BitmapOperationExecutor do
  describe '#call' do
    context 'when the operation is recognised' do
      it 'performs the operation provided in the input' do
        expect(Bitmap).to receive(:new).with(10, 10).and_call_original

        subject.call(['I', 10, 10])
      end
    end

    context 'when the operation is not recognised' do
      it 'does not perform the operation' do
        expect(subject.call(['A'])).to eq(false)
      end
    end
  end
end
