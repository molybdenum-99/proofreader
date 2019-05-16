class Proofreader
  class Short
    def initialize(short:)
      @short = short # Found no other attributes or nested elements in XML schema.
    end

    def self.call(short_xml)
      return nil if short_xml.empty?  # NOTE: No maxOccur specified in XML

      new(short: from_xml(short_xml))
    end

    class << self 
      
      private

      def from_xml(short_xml)
        short_xml.text
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
# TODO 1: No additional information about short on the XML documentation outside of its inclusion as a simple type inside of complex type elements