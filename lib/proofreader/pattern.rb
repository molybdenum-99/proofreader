class Proofreader
  class Pattern
    def initialize(raw_patterns)
      @tokens = extract_tokens(raw_patterns)
    end

    private

    def extract_tokens(raw_patterns)
      return nil if raw_patterns.empty?
      
      raw_tokens = raw_patterns.xpath('token')
      raw_tokens.map { |raw_token| raw_token.text }
    end
  end
end

# TODO: Figure out how to parse markers to separate tokens.