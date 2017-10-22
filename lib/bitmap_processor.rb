require_relative 'bitmap'
require_relative 'console_exporter'

class BitmapProcessor
  attr_accessor :bitmap, :exporter, :commands

  def initialize(commands:, exporter: ConsoleExporter)
    @commands = commands
    @exporter = exporter
  end

  def process
    raise 'No commands found' if commands.nil? || commands.empty?
    commands.each do |command|
      process_command(command)
    end
  end

  def process_command(command)
    case command
    when /I (\d+) (\d+)/
      @bitmap = ::Bitmap.new(width: $1, height: $2)
    when /L (\d+) (\d+) ([A-Z])/
      check_bitmap && bitmap.colour_pixel(column: $1, row: $2, colour: $3)
    when 'C'
      check_bitmap && bitmap.reset
    when /V (\d+) (\d+) (\d+) ([A-Z])/
      check_bitmap && bitmap.colour_column(column: $1, start_row: $2, end_row: $3, colour: $4)
    when /H (\d+) (\d+) (\d+) ([A-Z])/
      check_bitmap && bitmap.colour_row(start_column: $1, end_column: $2, row: $3, colour: $4)
    when 'S'
      raise 'No image to print' if bitmap.nil?
      exporter_processor = exporter.new(bitmap: bitmap.pixels)
      exporter_processor.process
    else
      puts 'Unrecognised command'
    end
  end

  private

  def check_bitmap
    raise 'Please provide an image' if bitmap.nil?
    true
  end
end
