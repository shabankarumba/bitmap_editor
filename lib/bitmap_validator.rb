# frozen_string_literal: true
class BitmapValidator
  MINIMUM_ROW_NUMBER = 1
  MAXIMUM_ROW_NUMBER = 250
  MINIMUM_COLUMN_NUMBER = 1
  MAXIMUM_COLUMN_NUMBER = 250

  def initialize(number_of_rows, number_of_columns)
    @errors = []
    @number_of_rows = number_of_rows
    @number_of_columns = number_of_columns
  end

  def valid?
    check_minimum_maximum_pixel_size
  end

  attr_reader :errors

  private

  attr_reader :number_of_rows, :number_of_columns

  def check_minimum_maximum_pixel_size
    if minimum_maximum_pixel_size?
      true
    else
      errors << 'Please provide a value which is between 1 and 250 for column and row numbers'
      false
    end
  end

  def minimum_maximum_pixel_size?
    (MINIMUM_ROW_NUMBER..MAXIMUM_ROW_NUMBER).cover?(number_of_rows) &&
      (MINIMUM_COLUMN_NUMBER..MAXIMUM_COLUMN_NUMBER).cover?(number_of_columns)
  end
end
