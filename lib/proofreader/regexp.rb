require_relative 'base'

class Proofreader
  class Regexp < Base
    initialize_with :case_sensitive, :type, :mark

    def self.from_xml(regexp_xml)
      return nil if regexp_xml.nil?
    
      new(
        case_sensitive: !!regexp_xml.attribute('case_sensitive')&.value == 'yes' ? true : false,
        type: regexp_xml.attribute('type')&.value,
        mark: regexp_xml.attribute('mark')&.value
      )
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
# TODO 1: Can we have more than on regexp nested inside an element? Can't find example grammar.xml's that have more than one.
# NOTE: Only 4 uses of the regexp tag in all of grammar.xml. It is much more commonly used as an attribute on other XML tags.