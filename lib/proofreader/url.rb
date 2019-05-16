class Proofreader
  class Url
    def initialize(url:)
      @url = url      # Found no other attributes or nested elements in XML schema.
    end

    def self.call(url_xml)
      return nil if url_xml.empty? # NOTE: maxOccur not specified

      new(url: from_xml(url_xml))
    end

    class << self 
      
      private

      def from_xml(url_xml)
        url_xml.text
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
# TODO 1: # TODO 1: No additional information about short on the XML documentation outside of its inclusion as a simple type inside of complex type elements