class Bitmap
  def initialize(number_of_rows, number_of_columns)
    @number_of_rows = number_of_rows
    @number_of_columns = number_of_columns
    @map = Array.new(number_of_rows) { Array.new(number_of_columns).fill { 'O' } }
  end

  def color_pixel(column_number, row_number, color)
    if valid?(row_number, column_number, color)
      map[adjusted_number(row_number)]
        .fetch(adjusted_number(column_number))
        .replace(color)
    else
      puts error_message(color, row_number, column_number)
    end
  end

  def color_pixels_horizontally(column_from, column_to, row_number, color)
    (column_from..column_to).each do |column_number|
      color_pixel(column_number, row_number, color)
    end

    show_map
  end

  def color_pixels_vertically(column_number, row_from, row_to, color)
    (row_from..row_to).each do |row_number|
      color_pixel(column_number, row_number, color)
    end

    show_map
  end

  def show_map
    map.each do |rows|
      puts rows.join(' ')
    end
  end

  private

  attr_reader :number_of_rows, :number_of_columns, :map

  def error_message(color, row_number, column_number)
    <<~MESSAGE
Please enter a color and column/row number which exists in the map,
as you entered the following arguments color: #{color},
column number: #{column_number} and row number: #{row_number}
    MESSAGE
  end

  def pixel_exists?(pixel, max_number)
    min_value, max_value = max_number.downto(1).minmax { |a, b| a <=> b }

    (min_value..max_value).cover?(pixel)
  end

  def valid?(row_number, column_number, color)
    pixel_exists?(row_number, number_of_rows) &&
      pixel_exists?(column_number, number_of_columns) &&
      !color.nil?
  end

  def adjusted_number(number)
    number - 1
  end
end
