require_relative 'match'

class Proofreader
  class Suggestion
    def initialize(suppress_misspelled:, suggestion:, match:)
      @suppress_misspelled = suppress_misspelled # Optional Attribute
      @match = match                             # Nested Element
      @suggestion = suggestion                   # Suggestion Text
    end

    def self.call(suggestions_xml)
      return nil if suggestions_xml.empty?

      suggestions_xml.map do |suggestion_xml|
        parsed_suggestion = from_xml(suggestion_xml)

        new(suppress_misspelled: parsed_suggestion[:suppress_misspelled], 
            match: parsed_suggestion[:match], 
            suggestion: parsed_suggestion[:suggestion])
      end
    end

    class << self

      private

      def from_xml(suggestion_xml)
        {
          suppress_misspelled: suggestion_xml.attribute('supress_misspelled')&.value,
          match: nil, #Match.call(suggestion_xml.attribute('match')),
          suggestion: suggestion_xml.text
        }
      end
    end
  end
end

# TODO 1: Create a Match class. 
