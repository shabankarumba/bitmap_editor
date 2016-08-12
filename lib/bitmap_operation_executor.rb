require './lib/bitmap'
require './lib/bitmap_validator'

class BitmapOperationExecutor
  OPERATIONS = {
    'I' => :create_bitmap,
    'H' => :color_pixels_horizontally,
    'V' => :color_pixels_vertically,
    'L' => :color_individual_pixel,
    'C' => :clear,
    'S' => :show_map
  }.freeze

  def call(input)
    @input = input
    operation = OPERATIONS.fetch(input.first) { return false }

    send(operation) if operation
  end

  private

  attr_reader :input, :bitmap, :original_column_number, :original_row_number

  def create_bitmap
    bitmap_validator = BitmapValidator.new(input[1].to_i, input[2].to_i)
    if bitmap_validator.valid?
      @bitmap = Bitmap.new(input[1].to_i, input[2].to_i)
      @original_row_number = input[1].to_i
      @original_column_number = input[2].to_i
      bitmap.show_map
    else
      puts bitmap_validator.errors
    end
  end

  def clear
    execute_operation do
      @bitmap = Bitmap.new(original_row_number, original_column_number)
      bitmap.show_map
    end
  end

  def color_individual_pixel
    execute_operation do
      bitmap.color_pixel(input[1].to_i, input[2].to_i, input[3])
      bitmap.show_map
    end
  end

  def color_pixels_vertically
    execute_operation do
      bitmap.color_pixels_vertically(input[1].to_i, input[2].to_i, input[3].to_i, input[4])
    end
  end

  def color_pixels_horizontally
    execute_operation do
      bitmap.color_pixels_horizontally(input[1].to_i, input[2].to_i, input[3].to_i, input[4])
    end
  end

  def show_map
    execute_operation do
      bitmap.show_map
    end
  end

  def execute_operation
    if defined?(@bitmap)
      yield
    else
      puts 'Please create a bitmap first'
    end
  end
end
