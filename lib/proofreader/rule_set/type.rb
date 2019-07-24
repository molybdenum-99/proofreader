require_relative 'base'

class Proofreader
  class RuleSet
    class Type < Base
      initialize_with :id

      def self.from_xml(type_xml)
        return nil if type_xml.nil?
        
        new(id: type_xml.attribute('id')&.value)
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# TODO 1: Can there be more than one type tag nested in any element.