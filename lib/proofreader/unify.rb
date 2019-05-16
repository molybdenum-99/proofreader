class Proofreader
  class Unify
    def initialize(negate:, feature:, and_value:, marker:, token:, unify_ignore:)
      @negate = negate              # Optional Attribute, Default: No
      @feature = feature            # Nested Element 
      @and = and_value              # Nested Element # NOTE: Renamed from and because and is a keyword and was causing an exception
      @marker = marker              # Nested Element
      @token = token                # Nested Element
      @unify_ignore = unify_ignore  # Nested Element
    end

    def self.call(unify_xmls)
      return [] if unify_xmls.empty? # NOTE: maxOccur unbounded

      unify_xmls.map do |unify_xml|
        parsed_unify = from_xml(unify_xml)

        new(negate: parsed_unify[:negate], 
            feature: parsed_unify[:feature],
            and_value: parsed_unify[:and_value],
            marker: parsed_unify[:marker],
            token: parsed_unify[:token],
            unify_ignore: parsed_unify[:unify_ignore])
      end
    end

    class << self

      private

      def from_xml(unify_xml)
        {
          negate: unify_xml.attribute('negate')&.value == 'yes' ? true : false, #TODO 1
          feature: Feature.call(unify_xml.xpath('feature')),
          and_value: And.call(unify_xml.xpath('and')),
          marker: Marker.call(unify_xml.xpath('marker')),
          token: Token.call(unify_xml.xpath('token')),
          unify_ignore: UnifyIgnore.call(unify_xml.xpath('unify_ignore'))
        }
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# TODO 1: Same issue other places, how to handle defalt value? Force to boolean, or keep as strings based on use in XML doc?
# NOTE 1: It doesn't appear that unify can have text. 
# NOTE 2: This grammar.xml shows an example of a unify tag with nested elements. https://github.com/languagetool-org/languagetool/blob/3b434b1db526c64a4482f083c4b1b96eb10da952/languagetool-language-modules/uk/src/main/resources/org/languagetool/rules/uk/grammar-grammar.xml