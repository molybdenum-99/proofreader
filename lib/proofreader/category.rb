require 'pry'
require_relative 'rule'
require_relative 'rule_group'
require_relative 'base'

class Proofreader 
  class Category < Base
    initialize_with :default, :name, :id, :type, :external, :tab, :rules, :rulegroups

    def self.from_xml(category_xml)
      # if category_xml.attributes['name'].value == 'Wikipedia' # Limiting scope to Wikipedia.
        new(
          default: category_xml.attribute('default')&.value == 'on' ? true : false,
          name: category_xml.attribute('name')&.value,
          id: category_xml.attribute('id')&.value,
          type: category_xml.attribute('type')&.value,
          external: category_xml.attribute('external')&.value,
          tab: category_xml.attribute('tab')&.value,
          rules: Rule.array_from_xml(category_xml.xpath('rule')),
          rulegroups: RuleGroup.array_from_xml(category_xml.xpath('rulegroup'))
        )
      # end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
