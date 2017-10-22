require_relative 'bitmap_processor'
require_relative './input/processor'

class BitmapEditor
  def run(file)
    file_processor = Input::Processor.new(file: file)
    processor = BitmapProcessor.new(commands: file_processor.parse)
    processor.process
  rescue RuntimeError => e
    puts e.message
  end
end
