class Proofreader
  class And
    def initialize(token:, marker:) 
      @token = token   # Nested Element
      @marker = marker # Nested Element
    end

    def self.call(and_xmls)
      return [] if and_xmls.empty? # NOTE: maxOccurs unbounded
      
      and_xmls.map do |and_xml|
        parsed_and = from_xml(and_xml)

        new(token: parsed_and[:token], marker: parsed_and[:marker])
      end
    end

    class << self

      private

      def from_xml(and_xml)
        {
          token: Token.call(and_xml.xpath('token')),
          marker: Marker.call(and_xml.xpath('marker'))
        }
      end
    end
  end
end


# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd