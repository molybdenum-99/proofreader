require 'pragmatic_segmenter'

class Proofreader
  class Segmenter < Base
    initialize_with :text, :language, segments: nil
    attr_reader :segments

    def tokenize
      @segments = ::PragmaticSegmenter::Segmenter.new(text: @text, language: @language).segment
    end
  end
end