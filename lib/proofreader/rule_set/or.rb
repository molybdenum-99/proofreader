require_relative 'base'

class Proofreader
  class RuleSet
    class Or < Base
      initialize_with :token

      def self.from_xml(or_xml)
        new(token: Token.array_from_xml(or_xml.xpath('token')))
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
