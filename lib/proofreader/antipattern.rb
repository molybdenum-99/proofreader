class Proofreader
  class Antipattern
    def initialize(raw_antipatterns)
      @tokens = extract_tokens(raw_antipatterns)
    end

    private

    def extract_tokens(raw_antipatterns)
      return nil if raw_antipatterns.empty?

      raw_tokens = raw_antipatterns.xpath('token')
      raw_tokens.map { |raw_token| raw_token.text }
    end
  end
end

# TODO: Figure out how to parse markers to separate tokens (if need be).