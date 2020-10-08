require 'logger'
require 'pry-byebug'
require 'thor'

require File.join(File.dirname(__FILE__), 'archives_space')

class ArchivesSpaceCli < Thor
  namespace :locales

  desc "build", "generates the locales"
  def build
    lyrasis_locales.each_value do |locale|
      if princeton_locales.include?(locale.id)
        princeton_locale = princeton_locales[locale.id]
        locale.merge(princeton_locale)
        built_locale = locale.dup
        logger.info("Copying the locale #{built_locale.id} from the Lyrasis release...")
      else
        built_locale = locale.dup
        logger.info("Merging the locale #{built_locale.id} from the Lyrasis release with the Princeton customization...")
      end

      built_locale_path = build_locale_path(locale: built_locale)
      built_locale.path = built_locale_path
      logger.info("Writing the locale #{built_locale.id} to #{built_locale.path}...")
      built_locale.write
    end
  end

  no_commands do

    def logger
      @logger ||= begin
                    built = Logger.new(STDOUT)
                    built.level = Logger::INFO
                    built
                  end
    end

    def root_path
      value = File.dirname(__FILE__)
      Pathname.new(value)
    end

    def build_locale_path(locale:)
      value = File.join('build', 'common', 'locales', locale.relative_path)
      Pathname.new(value)
    end

    def princeton_path
      value = File.join(root_path, 'dist', 'aspace.princeton.edu')
      Pathname.new(value)
    end

    def lyrasis_path
      value = File.join(root_path, 'dist', 'archivesspace')
      Pathname.new(value)
    end

    def princeton_configuration
      @princeton_configuration ||= ArchivesSpace::Configuration.new(path: princeton_path)
    end

    def princeton_locales
      princeton_configuration.locales
    end

    def lyrasis_configuration
      @lyrasis_configuration ||= ArchivesSpace::Configuration.new(path: lyrasis_path)
    end

    def lyrasis_locales
      lyrasis_configuration.locales
    end
  end
end
