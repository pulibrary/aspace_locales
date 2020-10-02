require 'yaml'

module ArchivesSpace
  class Locale
    attr_reader :values
    attr_accessor :path

    def initialize(path:)
      @path = path
      @values = to_h
    end

    def relative_path
      absolute = Pathname.new(@path)

      value = if absolute.dirname.to_s.include?('enums')
                File.join('enums', absolute.basename)
              else
                absolute.basename
              end
      value
    end

    def id
      relative_path
    end

    def file
      File.new(@path, "rb")
    end

    def file_contents
      contents = file.read
      file.close
      contents
    end

    def to_h
      @values ||= YAML.load(file_contents)
    end

    def to_yaml
      YAML.dump(to_h)
    end

    def write
      fh = File.new(@path, "wb")
      fh << to_yaml
      fh.close
      @path
    end

    def merge(new_locale)
      merged = to_h.merge(new_locale.to_h)
      @values = merged
    end
  end
end
