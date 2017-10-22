require_relative 'text_file'

module Input
  FILE_MAPPINGS = {
    '.txt' => Input::TextFile
  }

  class Processor
    def self.new(file:)
      raise RuntimeError, "File not provided" if file.nil? || !File.exists?(file)
      extension_name = File.extname(file)
      klass = FILE_MAPPINGS[extension_name]
      raise RuntimeError, "Invalid file type" if klass.nil?
      klass.new(file: file)
    end
  end
end
