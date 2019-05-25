require_relative 'base'

class Proofreader
  class RuleGroup < Base
    initialize_with :default, :name, :id, :type, :url, :short, :rule

    def self.from_xml(rulegroup_xml)
      new(
        default: rulegroup_xml.attribute('default')&.value == 'on' ? true : false,
        name: rulegroup_xml.attribute('name')&.value,
        id: rulegroup_xml.attribute('id')&.value,
        type: rulegroup_xml.attribute('type')&.value,
        url: Url.from_xml(rulegroup_xml.xpath('url')),
        short: Short.from_xml(rulegroup_xml.xpath('short')),
        rule: Rule.array_from_xml(rulegroup_xml.xpath('rule'))
      )
    end
  end
end

#SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
