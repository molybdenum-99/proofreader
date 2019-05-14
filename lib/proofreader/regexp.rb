class Proofreader
  class Regexp
    def initialize(case_sensitive:)
      @case_sensitive = case_sensitive
    end

    def self.call(regexp_xml)
      return nil if regexp_xml.empty?

      parsed_regexp = from_xml(regexp_xml) 

      new(case_sensitive: parsed_regexp[:case_sensitive])
    end

    class << self

      private

      def from_xml(regexp_xml)
        {
          case_sensitive: !!regexp_xml.attribute('case_sensitive')&.value
        }
      end
    end
  end
end

# NOTE: Only 4 uses of the regexp tag in all of grammar.xml. It is much more commonly used as an attribute on other XML tags.