require 'jekyll_asset_pipeline'
require 'compass'
require 'bootstrap-sass'

Compass.sass_engine_options[:load_paths].each do |path|
  Sass.load_paths << path
end

module JekyllAssetPipeline

  # process SCSS files
  class SassConverter < JekyllAssetPipeline::Converter

    Compass.configuration.sass_dir = 'src/_assets/css'

    Compass.sass_engine_options[:load_paths].each do |path|
      Sass.load_paths << path
    end

    def self.filetype
      '.scss'
    end

    def convert
      Sass::Engine.new(@content, syntax: :scss).render
    end
  end

  class CssCompressor < JekyllAssetPipeline::Compressor
    require 'yui/compressor'

    def self.filetype
      '.css'
    end

    def compress
      YUI::CssCompressor.new.compress(@content)
    end
  end

  class CoffeeScriptConverter < JekyllAssetPipeline::Converter
    require 'coffee-script'

    def self.filetype
      '.coffee'
    end

    def convert
      return CoffeeScript.compile(@content)
    end
  end
end