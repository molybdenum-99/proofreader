require 'nokogiri'
require 'pry'
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
      @pattern = pattern              # Nested Element
      @filter = filter                # Nested Element
      @regexp = regexp                # Nested Element
      @message = message              # Nested Element
      @suggestion                     # Nested Element TODO 2: According to XML schema, this is also nested under message. Is it more appropriate there? I've put it there for now.
      @url = url                      # Nested Element
      @short = short                  # Nested Element
      @examples = examples            # Nested Element NOTE: Example can be a collection but should we make it plural, or singular to map to the exact name of the XML tag (which is singular)
    end

    def self.call(rule_xmls)
      return [] if rule_xmls.empty?

      rule_xmls.map do |rule_xml|
        parsed_rule = from_xml(rule_xml)

        new(default: parsed_rule[:id],
          name: parsed_rule[:name],
          id: parsed_rule[:id],
          type: parsed_rule[:type],
          pattern: parsed_rule[:pattern],
          filter: parsed_rule[:filter],
          regexp: parsed_rule[:regexp],
          message: parsed_rule[:message],
          suggestion: parsed_rule[:suggestion],
          url: parsed_rule[:url],
          short: parsed_rule[:short],
          examples: parsed_rule[:example])
      end
    end

    class << self

      private

      def from_xml(rule_xml)
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

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
# TODO 1: See line on @suggestion inside initializer. @suggestion is listed under Message and Rule elements. Which one to nest under? Both?
# NOTE: Only one pattern tag inside each rule