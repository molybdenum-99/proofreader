class Proofreader
  class Match
    def initialize(no:, postag_regexp:, postag:, postag_replace:)
      @no = no                         # Attribute. Unknow if required or optional, schema doesn't say
      @postag_regexp = postag_regexp   # Attribute. Unknow if required or optional, schema doesn't say 
      @postag = postag                 # Attribute. Unknow if required or optional, schema doesn't say 
      @postag_replace = postag_replace # Attribute. Unknow if required or optional, schema doesn't say 
      @match = match                   # Match text (match? or matches) TODO 2
    end

    def self.call(match_xml)
      return nil if match_xml.empty?

      parsed_match = from_xml(match_xml)
      
      new(no: parsed_match[:no],
          postag_regexp: parsed_match[:postag_regexp],
          postag: parsed_match[:postag],
          postag_replace: parsed_match[:postag_replace],
          match: parsed_match[:match])
    end

    class << self

      private

      def from_xml(match_xml)
        binding.pry
        {
          no: match_xml.attribute('no')&.value,
          postag_regexp: match_xml.attribute('postag_regexp')&.value,
          postag: match_xml.attribute('postag')&.value,
          postag_replace: match_xml.attribute('postag_replace')&.value,
          match: match_xml.text,
        }
      end
    end
  end
end

# TODO 1: Find out all possible attributes and nested elements (if any); xml schema doc doesn't describe match in detail, but match in grammar.xml has many attributes
# TODO 2: How many times does match occcur in a suggestion? Only once? Or many times? XML schema doesn't specify.
# NOTE: An element nested under suggestion (and perhaps others?) 
