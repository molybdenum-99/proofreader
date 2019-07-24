require 'pragmatic_segmenter'

class Proofreader
  class InputTextParser
    class Segmenter
      attr_reader :segments

      def initialize(text:, language:, segments: nil) 
        @text = text
        @language = language
        @segments = segments
      end

      def segment
        @segments = ::PragmaticSegmenter::Segmenter.new(text: @text, language: @language).segment
      end
    end
  end
end