require_relative 'token'

class Proofreader
  class Equivalence
    def initialize(type:, equivalence:)
      @type = type      # Required Attribute
      @tokens = tokens  # Nested Element . NOTE: Token is a singular tag, but I'm pluralizing it since we can have many tokens. Is this okay?
    end

    def self.call(equivalence_xmls)
      return [] if equivalence_xmls.empty? # NOTE: No mention of maxOccur, but see NOTE 1.

      equivalence_xmls.map do |equivalence_xml|
        parsed_equivalence = from_xml(equivalence_xml)
      
        new(type: parsed_equivalence[:type], tokens: parsed_equivalence[:tokens])
      end
    end

    class << self

      private

      def from_xml(equivalence_xml)
        {
          type: equivalence_xml.attribute('type')&.value,
          tokens: Token.call(equivalence_xml.xpath('token'))
        }
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# NOTE 1: Example grammar.xml with multiple equivalences: https://github.com/languagetool-org/languagetool/blob/a59e098453f402ef4c7f774d2a0edecc3662224f/languagetool-language-modules/sr/src/main/resources/org/languagetool/rules/sr/grammar.xml 
          # They are listed under the first unification tag.
# NOTE 2: Equivalance does not have text, just nested elements.