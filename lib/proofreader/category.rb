require 'nokogiri'
require 'pry'
require_relative 'rule'
require_relative 'rule_group'

class Proofreader 
  class Category 
    def initialize(default:, id:, type:, name:, rules:)
      @default = default
      @id = id
      @type = type
      @name = name
      # @rulegroups = rulegroups
      @rules = rules
    end

    def self.call(category_xml)
      parsed_category = from_xml(category_xml)

      category = new(default: parsed_category[:default], 
          id: parsed_category[:id], 
          type: parsed_category[:type], 
          name: parsed_category[:name], 
          # rulegroups: parsed_category[:rulegroups], 
          rules: parsed_category[:rules])

      pp category
    end

    class << self

      private

      def from_xml(category_xml)
        {
          default: category_xml.attribute('default')&.value == 'off' ? false : true,
          id: category_xml.attribute('id')&.value,
          type: category_xml.attribute('type')&.value,
          name: category_xml.attribute('name')&.value,
          # rulegroups: RuleGroup.call(category_xml.xpath('rulegroup'))
          rules: Rule.call(category_xml.xpath('rule'))
        }
      end
    end

    # def parse_rules
    #   @raw_rules.each do |raw_rule|
    #     build_rule(raw_rule, raw_rule.attributes['id'].value, raw_rule.attributes['name'].value, false)
    #   end
      
    #   @raw_rulegroups.each do |raw_rulegroup|
    #     raw_rulegroup_rules = raw_rulegroup.xpath('rule')

    #     raw_rulegroup_rules.each do |raw_rulegroup_rule|
    #       build_rule(raw_rulegroup_rule, raw_rulegroup.attributes['id'].value, raw_rulegroup.attributes['name'].value, true)
    #     end
    #   end
    # end
  end
end

# NOTE: @rules only contains rules that aren't in a rulegroup. @rulegroups contains rules nested inside of rulegroups.
# TODO: Use category_xml.attribute('id'). Cleaner