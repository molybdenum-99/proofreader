require_relative 'input_text_parser/segmenter'
require_relative 'input_text_parser/tokenizer'
require_relative '../proofreader'

class Proofreader
  class InputTextParser
    attr_reader :segments, :tokens

    def initialize(text:, language: 'en')
      @text = text
      @segments = []
      @tokens = []
      @language = language
    end

    def parse
      @segments = Proofreader::InputTextParser::Segmenter.new(text: @text, language: @language).call
      @tokens = Proofreader::InputTextParser::Tokenizer.new(language: @language, segments: @segments).call
    end
  end
end