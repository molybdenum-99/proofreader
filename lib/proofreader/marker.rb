require_relative 'base'
require_relative 'or'
require_relative 'token'
require_relative 'unify'
require_relative 'and'
require_relative 'phraseref'
require_relative 'unify_ignore'

class Proofreader
  class Marker < Base
    initialize_with :or_value, :token, :unify, :and_value, :phraseref, :unify_ignore, :text

    def self.from_xml(marker_xmls)
      return [] if marker_xmls.nil?
      
      marker_xmls.map do |marker_xml|
        new(
          or_value: Or.from_xml(marker_xml.xpath('or')),
          token: Token.from_xml(marker_xml.xpath('token')),
          unify: Unify.from_xml(marker_xml.xpath('unify')),
          and_value: And.from_xml(marker_xml.xpath('and')),
          phraseref: Phraseref.from_xml(marker_xml.xpath('pharseref')),
          unify_ignore: UnifyIgnore.from_xml(marker_xml.xpath('unify-ignore')),
          text: marker_xml.text
        )
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# TODO 1: Is this a collection? Can there be more than one? Current class assumes only one. XML schema doesn't specify minOccurs or maxOccurs
# TODO 2: Return [] or nil? Since a collection is expected back (maxOccur for marker is unbounded) [] makes sense