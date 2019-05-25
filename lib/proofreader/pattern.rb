require_relative 'base'
require_relative 'token'

class Proofreader
  class Pattern < Base
    initialize_with :case_sensitive, :raw_pos, :tokens, :phraseref, :and_value, :or_value, :unify, :marker

    def self.from_xml(pattern_xml)
      new(
        case_sensitive: !!pattern_xml.attribute('case_sensitive')&.value == 'yes' ? true : false,
        raw_pos: pattern_xml.attribute('raw_pos')&.value,
        tokens: Token.array_from_xml(pattern_xml.xpath('token')),
        phraseref: Phraseref.array_from_xml(pattern_xml.xpath('phraseref')),
        and_value: And.array_from_xml(pattern_xml.xpath('and')),
        or_value: Or.array_from_xml(pattern_xml.xpath('or')),
        unify: Unify.array_from_xml(pattern_xml.xpath('unify')),
        marker: Marker.array_from_xml(pattern_xml.xpath('marker'))
      )
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
# TODO 2: Figure out how to use and, or elements. They connect token classes. Not creating classes out of them breaks the pattern of using a class for every xml tag.
