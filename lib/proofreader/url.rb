class Proofreader
  class Url
    def initialize(url:)
      @url = url      # Found no other attributes or nested elements in XML schema.
    end

    def self.call(url_xml)
      return nil if url_xml.empty?

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

# TODO 1: # TODO 1: No additional information about short on the XML documentation outside of its inclusion as a simple type inside of complex type elements