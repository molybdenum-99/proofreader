require_relative 'input_text_parser/segmenter'
require_relative 'input_text_parser/tokenizer'
require_relative '../proofreader'

class Proofreader
  class InputTextParser
    attr_reader :segments, :tokens

    def initialize(text:, segments: nil, tokens: nil, language: 'en')
      @text = text
      @segments = segments
      @tokens = tokens
      @language = language
    end

    def parse
      @segments = Proofreader::InputTextParser::Segmenter.new(text: @text, language: @language).segment
      @tokens = segments.map { |segment| Proofreader::InputTextParser::Tokenizer.new(segment: segment, language: @language).tokenize }
    end
  end
end