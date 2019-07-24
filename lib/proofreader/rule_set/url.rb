require_relative 'base'

class Proofreader
  class RuleSet
    class Url < Base
      initialize_with :url

      def self.from_xml(url_xml)
        return nil if url_xml.nil?
        
        new(url: url_xml.text)
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
# TODO 1: # TODO 1: No additional information about short on the XML documentation outside of its inclusion as a simple type inside of complex type elements