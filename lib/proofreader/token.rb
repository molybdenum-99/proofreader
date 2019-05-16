require_relative 'exception'

class Proofreader
  class Token
    def initialize(postag_regexp:, inflected:, negate:, regexp:, chunk:, spacebefore:, postag:, skip:, min:, max:, negate_pos:, case_sensitive:, exceptions:, marker:, token:)
      @postag_regexp = postag_regexp   # Optional Attribute
      @inflected = inflected           # Optional Attribute 
      @negate = negate                 # Optional Attribute
      @regexp = regexp                 # Optional Attribute
      @chunk = chunk                   # Optional Attribute
      @spacebefore = spacebefore       # Optional Attribute
      @postag = postag                 # Optional Attribute
      @skip = skip                     # Optional Attribute
      @min = min                       # Optional Attribute
      @max = max                       # Optional Attribute
      @negate_pos = negate_pos         # Optional Attribute
      @case_sensitive = case_sensitive # Optional Attribute
      @exceptions = exceptions         # Nested Element
      @marker = marker                 # Nested Element
      @token = token                   # NOTE: Token text.
    end

    def self.call(token_xmls)
      return [] if token_xmls.empty? # NOTE If we expect a collection, and there is not one, return empty array, else return nil (if object was expected, or single string, etc.)

      token_xmls.map do |token_xml|
        parsed_token = from_xml(token_xml) 

        new(postag_regexp: parsed_token[:postag_regexp],
            inflected: parsed_token[:inflected],
            negate: parsed_token[:negate],
            regexp: parsed_token[:regexp],
            chunk: parsed_token[:chunk],
            spacebefore: parsed_token[:spacebefore],
            postag: parsed_token[:postag],
            skip: parsed_token[:skip],
            min: parsed_token[:min],
            max: parsed_token[:max],
            negate_pos: parsed_token[:negate_pos],
            case_sensitive: parsed_token[:case_sensitive],
            exceptions: parsed_token[:exceptions],
            marker: parsed_token[:marker],
            token: parsed_token[:token])
      end
    end

    class << self

      private

      def from_xml(token_xml)
        { 
          postag_regexp: token_xml.attribute('postag_regexp')&.value == 'yes' ? true : false, # NOTE: default is 'no'
          inflected: token_xml.attribute('inflected')&.value == 'yes' ? true : false,
          negate: token_xml.attribute('negate')&.value == 'yes' ? true : false,
          regexp: token_xml.attribute('regexp')&.value == 'yes' ? true : false,
          chunk: token_xml.attribute('chunk')&.value,
          spacebefore: token_xml.attribute('spacebefore')&.value ? token_xml.attribute('spacebefore')&.value : 'ignore', # TODO 2
          postag: token_xml.attribute('postag')&.value ? token_xml.attribute('postag')&.value : 'ignore', # TODO 2
          skip: token_xml.attribute('skip')&.value,
          min: token_xml.attribute('min')&.value,
          max: token_xml.attribute('max')&.value,
          negate_pos: token_xml.attribute('negate_pos')&.value == 'yes' ? true : false,
          case_sensitive: token_xml.attribute('case_sensitive')&.value ? true : false,
          exceptions: Exception.call(token_xml.xpath('exception')),
          marker: Marker.call(token_xml.xpath('marker')),
          token: token_xml.text
        }
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd 
# TODO 1: Clean up
# TODO 2: See Master TODO as well. XML has different ways of listing options; 'yes/no', 'ignore', 'on/off'. Standardize? Or use XML nomenclature?