class Proofreader
  class Or
    def initialize(token:) 
      @token = token   # Nested Element
    end

    def self.call(or_xmls)
      return [] if or_xmls.empty? # NOTE: maxOccurs unbounded

      or_xmls.map do |or_xml|
        new(token: from_xml(or_xml))
      end
    end

    class << self

      private

      def from_xml(or_xml)
        Token.call(or_xml.xpath('token'))
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
