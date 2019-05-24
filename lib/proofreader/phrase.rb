require_relative 'base'

class Proofreader
  class Phrase < Base
    initialize_with :id, :unify, :and, :token, :includephrases

    def self.from_xml(phrase_xmls)
      return [] if phrase_xmls.nil?
      
      phrase_xmls.map do |phrase_xml|
        new(
          id: phrase_xml.attribute('id')&.value,
          unify: Unify.from_xml(phrase_xml.xpath('unify')),
          and: And.from_xml(phrase_xml.xpath('and')), 
          token: Token.from_xml(phrase_xml.xpath('token')),
          includephrases: Includephrases.from_xml(phrase_xml.xpath('includephrases'))
        )
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# NOTE: Phrase tags don't contain text.