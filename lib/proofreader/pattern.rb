require_relative 'token'

class Proofreader
  class Pattern
    def initialize(case_sensitive:, raw_pos:, tokens:, phraseref:, and_value:, or_value:, unify:, marker:)
      @case_sensitive = case_sensitive # Optional Attribute
      @raw_pos = raw_pos               # Optional Atribute
      @tokens = tokens                 # Nested Element
      @phraseref = phraseref           # Nested Element
      @and = and_value                 # Nested Element  # NOTE: Called and_value because and is a reserved word
      @or = or_value                   # Nested Element  # NOTE: Called or_value because or is a reserved word
      @unify = unify                   # Nested Element
      @marker = marker                 # Nested Element
    end

    def self.call(pattern_xml)
       return nil if pattern_xml.empty?

      parsed_pattern = from_xml(pattern_xml) 

      new(case_sensitive: parsed_pattern[:case_sensitive], 
          raw_pos: parsed_pattern[:raw_pos],
          tokens: parsed_pattern[:tokens],
          phraseref: parsed_pattern[:phraseref],
          and_value: parsed_pattern[:and],
          or_value: parsed_pattern[:or],
          unify: parsed_pattern[:unify],
          marker: parsed_pattern[:marker])
    end

    class << self

      private

      def from_xml(pattern_xml)
        {
          case_sensitive: !!pattern_xml.attribute('case_sensitive')&.value == 'yes' ? true : false,
          raw_pos: pattern_xml.attribute('raw_pos')&.value,
          tokens: Token.call(pattern_xml.xpath('token')),
          phraseref: nil, #Phraseref.call(pattern_xml.xpath('phraseref')),
          and_value: nil, #And.call(pattern_xml.xpath('and')),
          or_value: nil, #Or.call(pattern_xml.xpath('or')),
          unify: nil, #Unify.call(pattern_xml.xpath('unify')),
          marker: nil, #Marker.call(pattern_xml.xpath('marker'))
        }
      end
    end
  end
end

# TODO 1: Use Token class once Token class is constructed.
# TODO 2: Figure out how to use and, or elements. They connect token classes. Not creating classes out of them breaks the pattern of a class for every xml tag.
