require_relative 'category' 

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

    def self.call(rules_xml)
      return nil if rules_xml.empty?

      parsed_rules = from_xml(rules_xml)

      new(lang: parsed_rules[:lang], 
          idprefix: parsed_rules[:idprefix], 
          integrate: parsed_rules[:integrate],
          unification: parsed_rules[:unification],
          phrases: parsed_rules[:phrases],
          categories: parsed_rules[:categories])
    end

    class << self

      private

      def from_xml(rules_xml)
        {
          lang: rules_xml.attribute('lang')&.value,
          idprefix: rules_xml.attribute('idprefix')&.value,
          integrate: rules_xml.attribute('integrate')&.value,
          unification: nil, #Unification.call(rules_xml.xpath('unification'))
          phrases: nil, #Phrases.call(rules_xml.xpath('phrases'))
          categories: Category.call(rules_xml.xpath('category'))
        }
      end
    end
  end
end

# TODO: For future, create Unification and Phrases classes per XML documentation.