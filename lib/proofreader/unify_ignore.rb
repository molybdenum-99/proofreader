class Proofreader
  class UnifyIgnore
    def initialize(and_value:, marker:, token:)
      @and = and_value  # Nested Element #NOTE: Named and_value because using 'and' was causing an exception (since and is a keyword)
      @marker = marker  # Nested Element
      @token = token    # Nested Element
    end

    def self.call(unifiy_ignore_xmls) # NOTE: unifies because it says maxOccur: unbounded, so collection is expected
      return [] if unifiy_ignore_xmls.empty?

      unifiy_ignore_xmls.map do |unify_ignore_xml|
        parsed_unify_ignore = from_xml(unify_ignore_xml)

        new(and_value: parsed_unify_ignore[:and_value], marker: parsed_unify_ignore[:marker], token: parsed_unify_ignore[:token])
      end
    end

    class << self

      private

      def from_xml(unify_ignore_xml)
        {
          and_value: And.call(unify_ignore_xml.xpath('and')),
          marker: Marker.call(unify_ignore_xml.xpath('marker')),
          token: Token.call(unify_ignore_xml.xpath('token'))
        }
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# NOTE 1: Only two tags exist in the entire languagetool repo.
# NOTE 2: Only grammar.xml with a unify-ignore tag https://github.com/languagetool-org/languagetool/blob/467f91ea4f6e9f6de55899a9aa46a0745c055343/languagetool-language-modules/de/src/main/resources/org/languagetool/resource/de/disambiguation.xml
