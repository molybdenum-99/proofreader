class Proofreader
  class RuleGroup
    def initialize(default:, name:, id:, type:, url:, short:, rule:)
      @default = default           # Optional Attribute
      @name = name                 # Required Attribute
      @id = id                     # Required Attribute
      @type = type                 # Optional Attribute
      @url = url                   # Nested Element
      @short = short               # Nested Element
      @rule = rule                 # Nested Element
    end

    def self.call(rulegroup_xmls) #
      return [] if rulegroup_xmls.empty?

      rulegroup_xmls.map do |rulegroup_xml|
        parsed_rulegroup = from_xml(rulegroup_xml)
      
        new(default: parsed_rulegroup[:default], 
            name: parsed_rulegroup[:name],
            id: parsed_rulegroup[:id],
            type: parsed_rulegroup[:type],
            url: parsed_rulegroup[:url],
            short: parsed_rulegroup[:short],
            rule: parsed_rulegroup[:rule])
      end
    end

    class << self

      private

      def from_xml(rulegroup_xml)
        {
          default: rulegroup_xml.attribute('default')&.value == 'on' ? true : false,
          name: rulegroup_xml.attribute('name')&.value,
          id: rulegroup_xml.attribute('id')&.value,
          type: rulegroup_xml.attribute('type')&.value,
          url: Url.call(rulegroup_xml.xpath('url')),
          short: Short.call(rulegroup_xml.xpath('short')),
          rule: Rule.call(rulegroup_xml.xpath('rule'))
        }
      end
    end
  end
end

#SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
