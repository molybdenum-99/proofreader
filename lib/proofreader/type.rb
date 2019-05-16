class Proofreader
  class Type
    def initialize(id:)
      @id = id    #XML Schema doesn't specify if required. No other attributes or nested elements.
    end

    def self.call(type_xml)
      return nil if type_xml.empty? # NOTE: maxOccur not specified.

      new(id: from_xml(type_xml))
    end

    class << self

      private

      def from_xml(type_xml)
        type_xml.attribute('id')&.value,
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# TODO 1: Can there be more than one type tag nested in any element.