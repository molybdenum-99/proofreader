require_relative 'base'

class Proofreader
  class UnifyIgnore < Base
    initialize_with :and_value, :marker, :token

    def self.from_xml(unify_ignore_xmls)
      return [] if unify_ignore_xmls.nil?

      unify_ignore_xmls.map do |unify_ignore_xml|
        new(
          and_value: And.from_xml(unify_ignore_xml.xpath('and')),
          marker: Marker.from_xml(unify_ignore_xml.xpath('marker')),
          token: Token.from_xml(unify_ignore_xml.xpath('token'))
        )
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# NOTE 1: Only two tags exist in the entire languagetool repo.
# NOTE 2: Only grammar.xml with a unify-ignore tag https://github.com/languagetool-org/languagetool/blob/467f91ea4f6e9f6de55899a9aa46a0745c055343/languagetool-language-modules/de/src/main/resources/org/languagetool/resource/de/disambiguation.xml
