class Bitmap
  MAX_WIDTH = MAX_HEIGHT = 250
  MIN_WIDTH = MIN_HEIGHT = 1
  DEFAULT_COLOUR = 'O'.freeze

  attr_accessor :width, :height, :pixels

  def initialize(width:, height:)
    @width, @height = Integer(width), Integer(height)
    validate
    generate_pixels
  end

  def colour_pixel(column:, row:, colour:)
    column, row = Integer(column), Integer(row)
    return false unless valid_coordinate?(column, row)
    pixels[row - 1][column - 1] = colour
  end

  def colour_column(column:, start_row:, end_row:, colour:)
    column, start_row, end_row = Integer(column), Integer(start_row), Integer(end_row)

    return false unless valid_column_coordinates?(column, start_row, end_row)

    (start_row..end_row).each do |row|
      colour_pixel(column: column, row: row, colour: colour)
    end
  end

  def colour_row(start_column:, end_column:, row:, colour:)
    start_column, end_column, row = Integer(start_column), Integer(end_column), Integer(row)

    return false unless valid_row_coordinates?(start_column, end_column, row)

    (start_column..end_column).each do |column|
      colour_pixel(column: column, row: row, colour: colour)
    end
  end

  private

  def validate
    raise 'Image dimensions are invalid' unless valid_dimensions?
    true
  end

  def valid_dimensions?
    height >= MIN_HEIGHT && height <= MAX_HEIGHT &&
    width >= MIN_WIDTH && width <= MAX_WIDTH
  end

  def valid_coordinate?(column, row)
    valid_column?(column) && valid_row?(row)
  end

  def valid_column_coordinates?(column, start_row, end_row)
    valid_column?(column) && valid_row?(start_row) && valid_row?(end_row) && start_row <= end_row
  end

  def valid_row_coordinates?(start_column, end_column, row)
    valid_column?(start_column) && valid_column?(end_column) && valid_row?(row) && start_column <= end_column
  end

  def valid_column?(column)
    column.between?(1, width)
  end

  def valid_row?(row)
    row.between?(1, height)
  end

  def generate_pixels
    @pixels = Array.new(height) { Array.new(width, DEFAULT_COLOUR) }
  end
end
