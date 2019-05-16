class Proofreader
  class Filter
    def initialize(filter_class:, args: )
      @class = filter_class # Required Attribute
      @args = args          # Required Attribute
    end

    def self.call(filter_xml)
      return nil if filter_xml.empty? # NOTE: No mention of maxOccur in XML Schema

      parsed_filter = from_xml(filter_xml)
      
      new(filter_class: parsed_filter[:class], args: parsed_filter[:args])
    end

    class << self

      private

      def from_xml(filter_xml)
        {
          filter_class: filter_xml.attribute('class')&.value,
          args: filter_xml.attribute('args')&.value
        }
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
# NOTE: Only 7 uses of the filter tag in all of grammar.xml
# NOTE: Sample use of filter: https://github.com/languagetool-org/languagetool/blob/4d5b1c323a37990ea2ee583c3c4d58e9d5f7d555/languagetool-language-modules/pt/src/main/resources/org/languagetool/resource/pt/disambiguation.xml
