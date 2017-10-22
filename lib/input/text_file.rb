module Input
  class TextFile
    attr_accessor :file

    def initialize(file:)
      @file = File.open(file)
    end

    def parse
      lines = []
      file.each do |line|
        lines << line.chomp
      end
      lines
    end
  end
end
