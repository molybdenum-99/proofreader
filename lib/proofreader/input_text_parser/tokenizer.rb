require 'pragmatic_tokenizer'

class Proofreader
  class InputTextParser
    class Tokenizer
      attr_reader :tokens

      def initialize(segment:, language: 'en', tokens: nil)
        @segment = segment
        @language = language
        @tokens = tokens
      end

      def tokenize
        tokenizer = ::PragmaticTokenizer::Tokenizer.new(language: @language, 
                                                        expand_contractions: true, 
                                                        punctuation: :none,
                                                        classic_filter: true,
                                                        downcase: false,
                                                        contractions: { 'mr.' => 'mister', 'u.s.' => 'united states' })
        @tokens = tokenizer.tokenize(@segment)
      end
    end
  end
end