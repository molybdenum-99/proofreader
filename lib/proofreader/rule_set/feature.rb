require_relative 'base'

class Proofreader
  class RuleSet
    class Feature < Base
      initialize_with :id, :type

      def self.from_xml(feature_xml)
        new(
          id: feature_xml.attribute('id')&.value,
          type: Type.from_xml(feature_xml.xpath('type'))
        )
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# NOTE: See the following which contains feature tags. https://github.com/languagetool-org/languagetool/blob/3b434b1db526c64a4482f083c4b1b96eb10da952/languagetool-language-modules/uk/src/main/resources/org/languagetool/rules/uk/grammar-grammar.xml
 