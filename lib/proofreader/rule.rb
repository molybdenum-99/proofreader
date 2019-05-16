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
    def initialize(default:, name:, id:, type:, pattern:, filter:, regexp:, message:, suggestion:, url:, short:, examples:)
      @default = default              # Optional Attribute
      @name = name                    # Optional Attribute
      @id = id                        # Optional Attribute
      @type = type                    # Optional Attribute
      # @antipattern = antipattern    # Nested Element
      @pattern = pattern              # Nested Element
      @filter = filter                # Nested Element
      @regexp = regexp                # Nested Element
      @message = message              # Nested Element
      @suggestion                   # Nested Element TODO 2: According to XML schema, this is also nested under message. Is it more appropriate there? I've put it there for now.
      @url = url                      # Nested Element
      @short = short                  # Nested Element
      @examples = examples            # Nested Element NOTE: Example can be a collection but should we make it plural, or singular to map to the exact name of the XML tag (which is singular)
    end

    def self.call(rules_xml) #TODO 1
      return [] if rules_xml.empty?

      parsed_rules = from_xml(rules_xml)

      parsed_rules.each do |rule|
        new(default: rule[:id],
            name: rule[:name],
            id: rule[:id],
            type: rule[:type],
            pattern: rule[:pattern],
            filter: rule[:filter],
            regexp: rule[:regexp],
            message: rule[:message],
            suggestion: rule[:suggestion],
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
            default: rule_xml.attribute('default')&.value == 'on' ? true : false,
            name: rule_xml.attribute('name')&.value,
            id: rule_xml.attribute('id')&.value,
            type: rule_xml.attribute('type')&.value,
            pattern: Pattern.call(rule_xml.xpath('pattern')),
            filter: Filter.call(rule_xml.xpath('filter')),
            regexp: Regexp.call(rule_xml.xpath('regexp')),
            message: Message.call(rule_xml.xpath('message')),
            suggestion: Suggestion.call(rule_xml.xpath('suggestion')),
            url: Url.call(rule_xml.xpath('url')),
            short: Short.call(rule_xml.xpath('short')),
            example: Example.call(rule_xml.xpath('example'))
          }
        end
      end
    end
  end
end

# TODO 1: See line on @suggestion inside initializer. @suggestion is listed under Message and Rule elements. Which one to nest under? Both?
# NOTE: Only one pattern tag inside each rule