require_relative 'base'

class Proofreader
  class Match < Base
    initialize_with :no, :regexp_match, :regexp_replace, :postag_regexp, :postag, :postag_replace, :setpos, :case_conversion, :suppress_misspelled, :include_skipped

    def self.from_xml(match_xmls)
      return [] if match_xmls.nil?

      match_xmls.map do |match_xml|
        new(
          no: match_xml.attribute('no')&.value,
          regexp_match: match_xml.attribute('regexp_match')&.value,
          regexp_replace: match_xml.attribute('regexp_replace')&.value,
          postag_regexp: match_xml.attribute('postag_regexp')&.value == 'yes' ? true : false,
          postag: match_xml.attribute('postag')&.value,
          postag_replace: match_xml.attribute('postag_replace')&.value,
          setpos: match_xml.attribute('setpos')&.value == 'yes' ? true : false,
          case_conversion: match_xml.attribute('case_conversion')&.value,
          suppress_misspelled: match_xml.attribute('suppress_misspelled')&.value,
          include_skipped: match_xml.attribute('include_skipped')&.value
        )
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# NOTE 1: maxOccur not specified, but example with multiple match xmls nested found: SOURCE: https://github.com/languagetool-org/languagetool/blob/a59e098453f402ef4c7f774d2a0edecc3662224f/languagetool-language-modules/sk/src/main/resources/org/languagetool/rules/sk/grammar.xml
# NOTE 2: An element nested under suggestion (and perhaps others?) 
