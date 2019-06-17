require_relative 'base'
require_relative 'exception'

class Proofreader
  class Token < Base
    initialize_with :postag_regexp, :inflected, :negate, :regexp, :chunk, :spacebefore, :postag, :skip, :min, :max, :negate_pos, :case_sensitive, :exceptions, :marker, :token

    def self.from_xml(token_xml)
      new(
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
        exceptions: Exception.from_xml(token_xml.xpath('exception')),
        marker: Marker.array_from_xml(token_xml.xpath('marker')),
        token: token_xml.text
      )
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd 
# TODO 1: Clean up
# TODO 2: See Master TODO as well. XML has different ways of listing options; 'yes/no', 'ignore', 'on/off'. Standardize? Or use XML nomenclature?