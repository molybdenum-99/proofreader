require 'nokogiri'
require 'pry'
require_relative 'rule'
require_relative 'rule_group'

class Proofreader 
  class Category 
    def initialize(category)
      @category = category
      @default = @category.attributes['default'] ? false : true
      @id = @category.attributes['id']&.value
      @type = @category.attributes['type']&.value
      @name = @category.attributes['name']&.value
      @raw_rulegroups = @category.xpath('rulegroup')
      @raw_rules = @category.xpath('rule')
      @rules = []
      @errors = []
    end

    def call
      parse_rules
      binding.pry
      run_rules # FUTURE: Will run each rule, and place any errors into the @errors stack.
    end

    private

    def parse_rules
      @raw_rules.each do |raw_rule|
        build_rule(raw_rule, raw_rule.attributes['id'].value, raw_rule.attributes['name'].value, false)
      end
      
      @raw_rulegroups.each do |raw_rulegroup|
        raw_rulegroup_rules = raw_rulegroup.xpath('rule')

        raw_rulegroup_rules.each do |raw_rulegroup_rule|
          build_rule(raw_rulegroup_rule, raw_rulegroup.attributes['id'].value, raw_rulegroup.attributes['name'].value, true)
        end
      end
    end

    def build_rule(rule, id, name, rulegroup)
      @rules << Rule.new(id: id,
                         name: name,
                         category: @name,
                         rulegroup: rulegroup,
                         antipatterns: rule.xpath('antipattern'), 
                         patterns: rule.xpath('pattern'), 
                         filter: rule.xpath('filter'), 
                         regexp: rule.xpath('regexp'), 
                         message: rule.xpath('message'), 
                         url: rule.xpath('url'), 
                         short: rule.xpath('short'), 
                         examples: rule.xpath('example'))
    end

    def run_rules
    end
  end
end