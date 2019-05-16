class Proofreader
  class Match
    def initialize(no:, regexp_match:, regexp_replace:, postag_regexp:, postag:, postag_replace:, setpos:, case_conversion:, supress_misspelled:, include_skipped:)
      @no = no                                 # Required Attribute
      @regexp_match = regexp_match             # Optional Attribute
      @regexp_replace = regexp_replace         # Optional Attribute
      @postag_regexp = postag_regexp           # Optional Attribute 
      @postag = postag                         # Optional Attribute
      @postag_replace = postag_replace         # Optional Attribute 
      @setpos = setpos                         # Optional Attribute
      @case_conversion = case_conversion       # Optional Attribute
      @supress_misspelled = supress_misspelled # Optional Attribute
      @include_skipped = include_skipped       # Optional Attribute
    end

    def self.call(match_xmls)
      return [] if match_xmls.empty? # NOTE: NO maxOccur, but see NOTE 1

      match_xmls.map do |match_xml|
        parsed_match = from_xml(match_xml)
      
        new(no: parsed_match[:no],
            regexp_match: parsed_match[:regexp_match],
            regexp_replace: parsed_match[:regexp_replace],
            postag_regexp: parsed_match[:postag_regexp],
            postag: parsed_match[:postag],
            postag_replace: parsed_match[:postag_replace],
            setpos: parsed_match[:setpos],
            case_conversion: parsed_match[:case_conversion],
            supress_misspelled: parsed_match[:supress_misspelled],
            include_skipped: parsed_match[:include_skipped])
      end
    end

    class << self

      private

      def from_xml(match_xml)
        {
          no: match_xml.attribute('no')&.value,
          regexp_match: match_xml.attribute('regexp_match')&.value,
          regexp_replace: match_xml.attribute('regexp_replace')&.value,
          postag_regexp: match_xml.attribute('postag_regexp')&.value == 'yes' ? true : false,
          postag: match_xml.attribute('postag')&.value,
          postag_replace: match_xml.attribute('postag_replace')&.value,
          setpos: match_xml.attribute('setpos')&.value == 'yes' ? true : false,
          case_conversion: match_xml.attribute('case_conversion')&.value,
          supress_misspelled: match_xml.attribute('suppress_misspelled')&.value,
          include_skipped: match_xml.attribute('include_skipped')&.value
        }
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# NOTE 1: maxOccur not specified, but example with multiple match xmls nested found: SOURCE: https://github.com/languagetool-org/languagetool/blob/a59e098453f402ef4c7f774d2a0edecc3662224f/languagetool-language-modules/sk/src/main/resources/org/languagetool/rules/sk/grammar.xml
# NOTE 2: An element nested under suggestion (and perhaps others?) 
