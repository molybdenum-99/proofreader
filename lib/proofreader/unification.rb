require_relative 'base'
require_relative 'equivalence'

class Proofreader
  class Unification < Base
    initialize_with :feature, :equivalence

    def self.from_xml(unification_xmls)
      return [] if unification_xmls.nil?
      
      unification_xmls.map do |unification_xml|
        new(
          feature: unification_xml.attribute('feature')&.value,
          equivalence: Equivalence.from_xml(unification_xml.xpath('equivalence'))
        )
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd