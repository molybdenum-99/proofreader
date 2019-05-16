require 'pry'
require_relative 'rule'
require_relative 'rule_group'

class Proofreader 
  class Category 
    def initialize(default:, name:, id:, type:, external:, tab:, rules:, rulegroups:)
      @default = default       # Required attribute
      @name = name             # Optional attribute
      @id = id                 # Optional attribute 
      @type = type             # Optional attribute
      @external = external     # Optional attribute
      @tab = tab               # Optional attribute
      @rules = rules           # Nested Element
      @rulegroups = rulegroups # Nested Element
    end

    def self.call(categories_xml)
      return [] if categories_xml.empty?

      categories_xml.map do |category_xml|
        if category_xml.attributes['name'].value == 'Wikipedia' # NOTE: Parsed grammar.xml without raising, but still limiting scope to Wikipedia.
          parsed_category = from_xml(category_xml)

          new(default: parsed_category[:default], 
              name: parsed_category[:name], 
              id: parsed_category[:id], 
              type: parsed_category[:type], 
              external: parsed_category[:external], 
              tab: parsed_category[:tab], 
              rules: parsed_category[:rules],
              rulegroups: parsed_category[:rulegroups])
        end
      end.compact
    end

    class << self

      private

      def from_xml(category_xml)
        {
          default: category_xml.attribute('default')&.value == 'on' ? true : false,
          name: category_xml.attribute('name')&.value,
          id: category_xml.attribute('id')&.value,
          type: category_xml.attribute('type')&.value,
          external: category_xml.attribute('external')&.value,
          tab: category_xml.attribute('tab')&.value,
          rules: Rule.call(category_xml.xpath('rule')),
          rulegroups: RuleGroup.call(category_xml.xpath('rulegroup'))
        }
      end
    end
  end
end