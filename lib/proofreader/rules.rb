require_relative 'category' 
require_relative 'unification'
require_relative 'phrases'

class Proofreader
  class Rules
    def initialize(lang:, idprefix:, integrate:, unification:, phrases:, categories:)
      @lang = lang               # Required Attribute
      @idprefix = idprefix       # Optional Attribute
      @integrate = integrate     # Optional Attribute 
      @unification = unification # Nested Element
      @phrases = phrases         # Nested Element 
      @categories = categories   # Nested Element # NOTE: Tag is singular, but I made attribute plural. Use singular or plural?
    end

    def self.call(rules_xmls)
      return [] if rules_xmls.empty? # NOTE: maxOccur unbounded. Not what I expected. I assume one rules per lang, but I guess not.

      rules_xmls.map do |rules_xml|   
        parsed_rules = from_xml(rules_xml)

        new(lang: parsed_rules[:lang], 
            idprefix: parsed_rules[:idprefix], 
            integrate: parsed_rules[:integrate],
            unification: parsed_rules[:unification],
            phrases: parsed_rules[:phrases],
            categories: parsed_rules[:categories])
      end
    end

    class << self

      private

      def from_xml(rules_xml)
        {
          lang: rules_xml.attribute('lang')&.value,
          idprefix: rules_xml.attribute('idprefix')&.value,
          integrate: rules_xml.attribute('integrate')&.value,
          unification: Unification.call(rules_xml.xpath('unification')),
          phrases: Phrases.call(rules_xml.xpath('phrases')),
          categories: Category.call(rules_xml.xpath('category'))
        }
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd