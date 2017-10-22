require_relative 'text_file'

module Input
  FILE_MAPPINGS = {
    '.txt' => Input::TextFile
  }.freeze

  class Processor
    def self.new(file:)
      raise 'File not provided' if file.nil? || !File.exist?(file)
      extension_name = File.extname(file)
      klass = FILE_MAPPINGS[extension_name]
      raise 'Invalid file type' if klass.nil?
      klass.new(file: file)
    end
  end
end
