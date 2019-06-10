#from friends.nico

module Vocalodon
  module ExtractorExtension
    def extract_urls_with_indices(text, options = { extract_url_without_protocol: true })
      entities = extract_niconico_links_with_indices(text) + super(text, options)
      remove_overlapping_entities(entities)
    end

    def extract_niconico_links_with_indices(text)
      return [] unless text =~ NicoLink::NICOLINK_RE

      possible_entries = []

      text.to_s.scan(NicoLink::NICOLINK_RE) do |_match|
        nicolink = NicoLink.build($LAST_MATCH_INFO)
        possible_entries << {
          url: nicolink.url,
          niconico_link: nicolink,
          indices: nicolink.range,
        }
      end
      possible_entries
    end
  end
end
