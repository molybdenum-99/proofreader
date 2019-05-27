require_relative 'base'
require_relative 'match'

class Proofreader
  class Suggestion < Base
    initialize_with :suppress_misspelled, :suggestion, :matches

    def self.from_xml(suggestion_xml)
      new(
        suppress_misspelled: suggestion_xml.attribute('supress_misspelled')&.value,
        matches: Match.array_from_xml(suggestion_xml.xpath('match')),
        suggestion: suggestion_xml.text
      )
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
