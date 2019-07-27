require_relative 'base'
require_relative 'example'
require_relative 'filter'
require_relative 'message'
require_relative 'pattern'
require_relative 'regexp'
require_relative 'url'
require_relative 'short'

class Proofreader
  class Rule < Base
    initialize_with :default, :name, :id, :type, :pattern, :filter, :regexp, :message, :suggestion, :url, :short, :examples

    def self.from_xml(rule_xml)
      new(
        default: rule_xml.attribute('default')&.value == 'on' ? true : false,
        name: rule_xml.attribute('name')&.value,
        id: rule_xml.attribute('id')&.value,
        type: rule_xml.attribute('type')&.value,
        pattern: Pattern.array_from_xml(rule_xml.xpath('pattern')),
        filter: Filter.from_xml(rule_xml.xpath('filter')),
        regexp: Regexp.from_xml(rule_xml.xpath('regexp')),
        message: Message.array_from_xml(rule_xml.xpath('message')),
        suggestion: Suggestion.array_from_xml(rule_xml.xpath('suggestion')),
        url: Url.from_xml(rule_xml.xpath('url')),
        short: Short.from_xml(rule_xml.xpath('short')),
        examples: Example.array_from_xml(rule_xml.xpath('example'))
      )
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
# TODO 1: See line on @suggestion inside initializer. @suggestion is listed under Message and Rule elements. Which one to nest under? Both?
# NOTE: Only one pattern tag inside each rule
