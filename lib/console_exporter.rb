class ConsoleExporter
  attr_accessor :bitmap

  def initialize(bitmap:)
    @bitmap = bitmap
  end

  def process
    return false unless bitmap
    puts bitmap.map { |row| row.join('') }.join("\n")
  end
end
