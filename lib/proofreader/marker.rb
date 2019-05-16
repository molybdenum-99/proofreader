require_relative 'or'
require_relative 'token'
require_relative 'unify'
require_relative 'and'
require_relative 'phraseref'
require_relative 'unify_ignore'

class Proofreader
  class Marker
    def initialize(or_value:, token:, unify:, and_value:, phraseref:, unify_ignore:, text:)
      @or = or_value               # Nested Element NOTE: Had to name it to or_value since 'or' is a keyword and was causing raised exception.
      @token = token               # Nested Element
      @unify = unify               # Nested Element
      @and = and_value             # Nested Element NOTE: Had to name and_value since and is a keyword and was causing raised exception.
      @phraseref = phraseref       # Nested Element
      @unify_ignore = unify_ignore # Nested Element
      @text = text                 # Marker Text
    end

    def self.call(marker_xmls)
      return [] if marker_xmls.empty? # NOTE: maxOccur unbounded. See TODO 2

      marker_xmls.map do |marker_xml|
        parsed_marker = from_xml(marker_xml)

        new(or_value: parsed_marker[:or_value],
            token: parsed_marker[:token],
            unify: parsed_marker[:unify],
            and_value: parsed_marker[:and_value],
            phraseref: parsed_marker[:phraseref],
            unify_ignore: parsed_marker[:unify_ignore],
            text: parsed_marker[:text])
      end
    end

    class << self

      private

      def from_xml(marker_xml)
        {
          or_value: Or.call(marker_xml.xpath('or')),
          token: Token.call(marker_xml.xpath('token')),
          unify: Unify.call(marker_xml.xpath('unify')),
          and_value: And.call(marker_xml.xpath('and')),
          phraseref: Phraseref.call(marker_xml.xpath('pharseref')),
          unify_ignore: UnifyIgnore.call(marker_xml.xpath('unify-ignore')),
          text: marker_xml.text
        }
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# TODO 1: Is this a collection? Can there be more than one? Current class assumes only one. XML schema doesn't specify minOccurs or maxOccurs
# TODO 2: Return [] or nil? Since a collection is expected back (maxOccur for marker is unbounded) [] makes sense