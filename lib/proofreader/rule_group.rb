class Proofreader
  class RuleGroup
    def initialize(default:, name:, id:, type:, url:, short:, rule:)
      @default = default           # Optional Attribute
      @name = name                 # Required Attribute
      @id = id                     # Required Attribute
      @type = type                 # Optional Attribute
      @url = url                   # Nested Element
      @short = short               # Nested Element
      # @antipattern = antipattern # Nested Element # TODO 2
      @rule = rule                 # Nested Element
    end

    def self.call(rulegroups_xml) # TODO 1
      return [] if rulegroups_xml.empty?

      rulegroups_xml.map do |rulegroup_xml|
        parsed_rulegroup = from_xml(rulegroup_xml)
      
        new(default: parsed_rulegroup[:default], 
            name: parsed_rulegroup[:name],
            id: parsed_rulegroup[:id],
            type: parsed_rulegroup[:type],
            url: parsed_rulegroup[:url],
            # antipattern
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
          # antipattern
          short: Short.call(rulegroup_xml.xpath('short')),
          rule: Rule.call(rulegroup_xml.xpath('rule'))
        }
      end
    end
  end
end

# TODO 1: Verify we don't need antipattern.