module Jekyll
  module StripEmojiShortcodes
    # Remove :shortcode: tokens so jemoji cannot inject <img> tags into JS strings.
    def strip_emoji_shortcodes(input)
      input.to_s.gsub(/:[\w+-]+:/, "").gsub(/\s+/, " ").strip
    end
  end
end

Liquid::Template.register_filter(Jekyll::StripEmojiShortcodes)
