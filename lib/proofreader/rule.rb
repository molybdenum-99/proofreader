require 'nokogiri'
require 'pry'
require_relative 'antipattern'
require_relative 'example'
require_relative 'filter'
require_relative 'message'
require_relative 'pattern'
require_relative 'regexp'
require_relative 'url'
require_relative 'short'

class Proofreader
  class Rule
    def initialize(id:, name:, pattern:, filter:, regexp:, message:, url:, short:, examples:)
      @id = nil
      @name = nil
      # @antipattern = nil #Antipattern.new(options[:antipattern])
      @pattern = nil
      @filter = nil
      @regexp = nil
      @message = nil
      @url = nil
      @short = nil
      @examples = nil
    end

    def self.call(rules_xml) #TODO 1
      parsed_rules = from_xml(rules_xml)

      parsed_rules.each do |rule|
        new(id: rule[:id],
            name: rule[:name],
            pattern: rule[:pattern],
            filter: rule[:filter],
            regexp: rule[:regexp],
            message: rule[:message],
            url: rule[:url],
            short: rule[:short],
            examples: rule[:example])
      end
    end

    class << self

      private

      def from_xml(rules_xml)
        rules_xml.map do |rule_xml|
          {
            id: rule_xml.attributes['id'].value,
            name: rule_xml.attributes['name'].value,
            pattern: Pattern.call(rule_xml.xpath('pattern')),
            filter: Filter.call(rule_xml.xpath('filter')),
            regexp: Regexp.call(rule_xml.xpath('regexp')),
            message: Message.call(rule_xml.xpath('message')),
            url: Url.call(rule_xml.xpath('url')),
            short: Short.call(rule_xml.xpath('short')),
            example: Example.call(rule_xml.xpath('example'))
          }
        end
      end
    end
  end
end

# TODO 1: is_a?(Array) when you only have one rule
# NOTE: Only one pattern tag inside each rule