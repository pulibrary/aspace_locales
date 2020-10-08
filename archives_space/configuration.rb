module ArchivesSpace
  class Configuration

    def initialize(path:)
      @path = path
    end

    def locales_root_path
      File.join(@path, 'common', 'locales')
    end

    def enum_path
      File.join(locales_root_path, 'enums')
    end

    def locales_paths
      glob_pattern = File.join(locales_root_path, '*yml')
      Dir.glob(glob_pattern)
    end

    def enum_locale_paths
      glob_pattern = File.join(enum_path, '*yml')
      Dir.glob(glob_pattern)
    end

    def global_locales
      entries = locales_paths
      entries.map { |e| Locale.new(path: e) }
    end

    def enum_locales
      entries = enum_locale_paths
      entries.map { |e| Locale.new(path: e) }
    end

    def locales
      values = {}
      (global_locales + enum_locales).each do |locale|
        values[locale.id] = locale
      end
      values
    end
  end
end
