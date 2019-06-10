require 'pragmatic_tokenizer'

class Proofreader
  class Tokenizer < Base
    initialize_with :segment, :language, tokens: nil
    attr_reader :tokens

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