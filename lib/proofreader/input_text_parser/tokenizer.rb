require 'pragmatic_tokenizer'

class Proofreader
  class InputTextParser
    class Tokenizer
      attr_reader :tokens

      def initialize(language: 'en', segments:)
        @language = language
        @segments = segments
        @tokens = []
      end

      def call
        tokenizer = ::PragmaticTokenizer::Tokenizer.new(language: @language, 
                                                        expand_contractions: true, 
                                                        punctuation: :none,
                                                        classic_filter: true,
                                                        downcase: false,
                                                        contractions: { 'mr.' => 'mister', 'u.s.' => 'united states' })

        @tokens = @segments.map { |segment| tokenizer.tokenize(segment) }
      end
    end
  end
end