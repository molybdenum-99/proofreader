require_relative 'base'
require_relative 'category' 
require_relative 'unification'
require_relative 'phrases'

class Proofreader
  class Rules < Base
    initialize_with :lang, :idprefix, :integrate, :unification, :phrases, :categories

    def self.from_xml(rules_xml)
      new(
        lang: rules_xml.attribute('lang')&.value,
        idprefix: rules_xml.attribute('idprefix')&.value,
        integrate: rules_xml.attribute('integrate')&.value,
        unification: Unification.array_from_xml(rules_xml.xpath('unification')),
        phrases: Phrases.from_xml(rules_xml.xpath('phrases')),
        categories: Category.array_from_xml(rules_xml.xpath('category'))
      )
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd