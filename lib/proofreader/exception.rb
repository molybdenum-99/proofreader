require_relative 'base'

class Proofreader
  class Exception < Base
    initialize_with :postag_regexp, :negate_pos, :postag, :spacebefore, :inflected, :scope, :regexp, :negate, :case_sensitive, :exception_text

    def self.from_xml(exception_xml)
      return [] if exception_xml.nil?
      
      new(
        postag_regexp: exception_xml.attribute('postag_regexp')&.value == 'yes' ? true : false,
        negate_pos: exception_xml.attribute('negate_pos')&.value == 'yes' ? true : false,
        postag: exception_xml.attribute('postag')&.value,
        spacebefore: exception_xml.attribute('spacebefore')&.value ? exception_xml.attribute('spacebefore')&.value : 'ignore', # TODO 2
        inflected: exception_xml.attribute('inflected')&.value == 'yes' ? true : false,
        scope: exception_xml.attribute('scope')&.value ? exception_xml.attribute('scope')&.value : 'current', # TODO 3
        regexp: exception_xml.attribute('regexp')&.value == 'yes' ? true : false,
        negate: exception_xml.attribute('negate')&.value == 'yes' ? true : false,
        case_sensitive: exception_xml.attribute('case_sensitive')&.value,
        exception_text: exception_xml.text
      )
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# TODO 1: Verify that 'yes' ? true: false is a good way of doing this. Master TODO in proofreader file discusses this too.
# TODO 2: How to more elegantly handle ignore?
# TODO 3: How to handle current in default?
# TODO 4: Doesn't specify maxOccur in XML schema. I will need to check in other grammar.xml files