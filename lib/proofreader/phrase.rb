class Proofreader
  class Phrase
    def initialize(id:, unify:, and:, token:, includephrases:)
      @id = id                          # Required attribute
      @unify = unify                    # Nested Element
      @and = and                        # Nested Element
      @token = token                    # Nested Element
      @includephrases = includephrases  # Nested Element
    end

    def self.call(phrase_xmls)
      return [] if phrase_xmls.empty? # NOTE: maxOccurs unbounded

      phrase_xmls.map do |phrase_xml|

        parsed_phrase = from_xml(phrase_xml)
      
        new(id: parsed_phrase[:id],
            unify: parsed_phrase[:unify],
            and: parsed_phrase[:and],
            token: parsed_phrase[:token],
            includephrases: parsed_phrase[:includephrases])
      end
    end

    class << self

      private

      def from_xml(phrase_xml)
        {
          id: phrase_xml.attribute('id')&.value,
          unify: Unify.call(phrase_xml.xpath('unify')),
          and: And.call(phrase_xml.xpath('and')),       # NOTE: Feels odd to have and. There is also an Or class. 
          token: Token.call(phrase_xml.xpath('token')),
          includephrases: Includephrases.call(phrase_xml.xpath('includephrases'))
        }
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# NOTE: Phrase tags don't contain text.