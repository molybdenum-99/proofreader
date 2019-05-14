require_relative 'base'

class Proofreader
  class Short < Base
    initialize_with :short

    def self.from_xml(short_xml)
      return nil if short_xml.nil?
      
      new(short: short_xml.text)
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
# TODO 1: No additional information about short on the XML documentation outside of its inclusion as a simple type inside of complex type elements
