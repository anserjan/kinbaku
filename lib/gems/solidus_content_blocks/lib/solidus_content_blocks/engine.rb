module SolidusContentBlocks
  class Engine < Rails::Engine
    engine_name 'solidus_content_blocks'

    config.autoload_paths += %W(#{config.root}/lib)

    config.content_block_types = [
      "richtext", "richtext_image_left", "richtext_image_right", "embed", "stage", "three_squares", "center_image"
    ]

    config.partition_enums = [
      "text_50_images_50", "text_67_images_33", "text_33_images_67",
      "images_50_text_50", "images_67_text_33", "images_33_text_67"
    ]

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
