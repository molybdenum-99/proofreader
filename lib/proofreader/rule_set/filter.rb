require_relative 'base'

class Proofreader
  class RuleSet
    class Filter < Base
      initialize_with :filter_class, :args

      def self.from_xml(filter_xml)
        return nil if filter_xml.nil?
        
        new(
          filter_class: filter_xml.attribute('class')&.value,
          args: filter_xml.attribute('args')&.value
        )
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
# NOTE: Only 7 uses of the filter tag in all of grammar.xml
# NOTE: Sample use of filter: https://github.com/languagetool-org/languagetool/blob/4d5b1c323a37990ea2ee583c3c4d58e9d5f7d555/languagetool-language-modules/pt/src/main/resources/org/languagetool/resource/pt/disambiguation.xml
