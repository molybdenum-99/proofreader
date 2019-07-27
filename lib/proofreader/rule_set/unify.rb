require_relative 'base'

class Proofreader
  class RuleSet
    class Unify < Base
      initialize_with :negate, :feature, :and_value, :marker, :token, :unify_ignore
      
      def self.from_xml(unify_xml)
        new(
          negate: unify_xml.attribute('negate')&.value == 'yes' ? true : false, #TODO 1
          feature: Feature.array_from_xml(unify_xml.xpath('feature')),
          and_value: And.array_from_xml(unify_xml.xpath('and')),
          marker: Marker.array_from_xml(unify_xml.xpath('marker')),
          token: Token.array_from_xml(unify_xml.xpath('token')),
          unify_ignore: UnifyIgnore.array_from_xml(unify_xml.xpath('unify_ignore'))
        )
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# TODO 1: Same issue other places, how to handle defalt value? Force to boolean, or keep as strings based on use in XML doc?
# NOTE 1: It doesn't appear that unify can have text. 
# NOTE 2: This grammar.xml shows an example of a unify tag with nested elements. https://github.com/languagetool-org/languagetool/blob/3b434b1db526c64a4482f083c4b1b96eb10da952/languagetool-language-modules/uk/src/main/resources/org/languagetool/rules/uk/grammar-grammar.xml