require_relative 'base'
require_relative 'suggestion'

class Proofreader
  class RuleSet
    class Message < Base
      initialize_with :suggestions, :matches, :text

      def self.from_xml(message_xml)
        new( 
          suggestions: Suggestion.array_from_xml(message_xml.xpath('suggestion')),
          matches: Match.array_from_xml(message_xml.xpath('match')),
          text: message_xml.text
        )
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
# TODO: Should Suggestion be namespaced under Message? So Proofreader::Message::Suggestion? Or not?
# NOTE: 
