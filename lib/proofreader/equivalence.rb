require_relative 'base'
require_relative 'token'

class Proofreader
  class Equivalence < Base
    initialize_with :type, :equivalence

    def self.from_xml(equivalence_xmls)
      return [] if equivalence_xmls.nil?
      
      equivalence_xmls.map do |equivalence_xml|
        new(
          type: equivalence_xml.attribute('type')&.value,
          tokens: Token.from_xml(equivalence_xml.xpath('token'))
        )
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# NOTE 1: Example grammar.xml with multiple equivalences: https://github.com/languagetool-org/languagetool/blob/a59e098453f402ef4c7f774d2a0edecc3662224f/languagetool-language-modules/sr/src/main/resources/org/languagetool/rules/sr/grammar.xml 
          # They are listed under the first unification tag.
# NOTE 2: Equivalance does not have text, just nested elements.