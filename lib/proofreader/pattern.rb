class Proofreader
  class Pattern
    def initialize(case_sensitive:, tokens: )
      @case_sensitive = case_sensitive
      @tokens = tokens
    end

    def self.call(pattern_xml)
       return nil if pattern_xml.empty?

      parsed_pattern = from_xml(pattern_xml) 

      new(case_sensitive: parsed_pattern[:case_sensitive], tokens: parsed_pattern[:tokens])
    end

    class << self

      private

      def from_xml(pattern_xml)
        {
          case_sensitive: !!pattern_xml.attribute('case_sensitive')&.value,
          tokens: nil #Token.call(pattern_xml.xpath('token'))
        }
      end
    end
  end
end

# TODO 1: Use Token class once Token class is constructed.
# TODO 2: It's not enough to do .attribute('case_sensitive') need to add .name. VERIFY