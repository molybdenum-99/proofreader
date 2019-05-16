require_relative 'match'

class Proofreader
  class Suggestion
    def initialize(suppress_misspelled:, suggestion:, matches:)
      @suppress_misspelled = suppress_misspelled # Optional Attribute
      @matches = matches                         # Nested Element
      @suggestion = suggestion                   # Suggestion Text
    end

    def self.call(suggestion_xmls)
      return [] if suggestion_xmls.empty? # NOTE: maxOccur unbounded

      suggestion_xmls.map do |suggestion_xml|
        parsed_suggestion = from_xml(suggestion_xml)

        new(suppress_misspelled: parsed_suggestion[:suppress_misspelled], 
            matches: parsed_suggestion[:matches], 
            suggestion: parsed_suggestion[:suggestion])
      end
    end

    class << self

      private

      def from_xml(suggestion_xml)
        {
          suppress_misspelled: suggestion_xml.attribute('supress_misspelled')&.value,
          matches: Match.call(suggestion_xml.xpath('match')),
          suggestion: suggestion_xml.text
        }
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
