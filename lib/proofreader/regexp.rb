class Proofreader
  class Regexp
      def initialize(case_sensitive:, type:, mark:)
      @case_sensitive = case_sensitive # Optional Attribute
      @type = type                     # Optional Attribute
      @mark = mark                     # Optional Attribute
    end

    def self.call(regexp_xml)
      return nil if regexp_xml.empty? # NOTE: No maxOccur specified. See TODO: 1

      parsed_regexp = from_xml(regexp_xml) 

      new(case_sensitive: parsed_regexp[:case_sensitive], type: parsed_regexp[:type], mark: parsed_regexp[:mark])
    end

    class << self

      private

      def from_xml(regexp_xml)
        {
          case_sensitive: !!regexp_xml.attribute('case_sensitive')&.value == 'yes' ? true : false,
          type: regexp_xml.attribute('type')&.value,
          mark: regexp_xml.attribute('mark')&.value
        }
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
# TODO 1: Can we have more than on regexp nested inside an element? Can't find example grammar.xml's that have more than one.
# NOTE: Only 4 uses of the regexp tag in all of grammar.xml. It is much more commonly used as an attribute on other XML tags.