class Proofreader
  class Token
    def initialize(regexp:, token: )
      @case_sensitive = case_sensitive
      @token = token # NOTE: Named singular token when there can be more? Rename to tokens?
    end

    def self.call(pattern_xml)
      parsed_pattern = from_xml(pattern_xml) 
    end

    class << self

      private

      def from_xml(pattern_xml)
        {
          case_sensitive: !!pattern_xml.attributes['case_sensitive']&.value,
          token: Token.call(pattern_xml.xpath('token')) # NOTE: Ensure token includes tokens separated by markers.
        }
      end
    end

    # def extract_tokens(raw_patterns)
    #   return nil if raw_patterns.empty?
      
    #   raw_tokens = raw_patterns.xpath('token')
    #   raw_tokens.map { |raw_token| raw_token.text }
    # end
  end
end

# TODO: Figure out how to parse markers to separate tokens.