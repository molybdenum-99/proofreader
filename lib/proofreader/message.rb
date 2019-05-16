require_relative 'suggestion'

class Proofreader
  class Message
    def initialize(suggestions:, matches:, text:) 
      @suggestions = suggestions    # Nested Element
      @matches = matches            # Nested Element
      @text = text                  # Text  # NOTE: Text includes the text inside of the suggestion tag as well.
    end

    def self.call(message_xmls)
      return [] if message_xmls.empty? # NOTE: maxOccur unbounded

      message_xmls.map do |message_xml|
        parsed_message = from_xml(message_xml) 

        new(suggestions: parsed_message[:suggestions], 
            matches: parsed_message[:matches],
            text: parsed_message[:text])
      end
    end

    class << self

      private

      def from_xml(message_xml)
        {
          suggestions: Suggestion.call(message_xml.xpath('suggestion')),
          matches: Match.call(message_xml.xpath('match')),
          text: message_xml.text
        }
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
# TODO: Should Suggestion be namespaced under Message? So Proofreader::Message::Suggestion? Or not?
# NOTE: 
