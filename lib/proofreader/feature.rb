class Proofreader
  class Feature
    def initialize(id:, type:)
      @id = id     # Required Attribute
      @type = type # Nested Element
    end

    def self.call(feature_xmls)
      return [] if feature_xmls.empty? # NOTE: maxOccur unbounded.

      feature_xmls.map do |feature_xml|
        parsed_feature = from_xml(feature_xml)

        new(id: parsed_feature[:id], type: parsed_feature[:type])
      end
    end

    class << self

      private

      def from_xml(feature_xml)
        {
          id: feature_xml.attribute('id')&.value,
          type: Type.call(feature_xml.xpath('type'))
        }
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# NOTE: See the following which contains feature tags. https://github.com/languagetool-org/languagetool/blob/3b434b1db526c64a4482f083c4b1b96eb10da952/languagetool-language-modules/uk/src/main/resources/org/languagetool/rules/uk/grammar-grammar.xml
 