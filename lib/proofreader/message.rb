class Proofreader
  class Message
    def initialize(message:, suggestions:)
      @message = message
      @suggestions = suggestions
    end

    def self.call(message_xml)
      return nil if message_xml.empty?

      parsed_message = from_xml(message_xml) 

      new(message: parsed_message[:message], suggestions: parsed_message[:suggestions])
    end

    class << self

      private

      def from_xml(message_xml)
        {
          message: message_xml.attribute('case_sensitive')&.value,
          suggestions: nil #Suggestion.call(message_xml.xpath('suggestion')) # TODO 2
        }
      end
    end
  end
end

# TODO: Should Suggestion be namespaced under Message? So Proofreader::Message::Suggestion? Suggestion tags only appear under messages
# this has ramifications for other tags that only ever appear under under tags (only patterns and antipatterns have token if I recall correctly?)

# TODO 2: Implement Suggestion class.