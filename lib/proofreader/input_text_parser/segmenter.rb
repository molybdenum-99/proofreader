require 'pragmatic_segmenter'

class Proofreader
  class InputTextParser
    class Segmenter
      attr_reader :segments

      def initialize(text:, language:) 
        @text = text
        @language = language
        @segments = []
      end

      def call
        @segments = ::PragmaticSegmenter::Segmenter.new(text: @text, language: @language).segment
      end
    end
  end
end