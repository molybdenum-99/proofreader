require_relative 'base'
require_relative 'marker'

class Proofreader
  class Example < Base
    initialize_with :correction, :type, :reason, :marker, :example

    def self.from_xml(example_xml)
      new(
        correction: example_xml.attribute('correction')&.value,
        type: example_xml.attribute('type')&.value,
        reason: example_xml.attribute('reason')&.value,
        marker: Marker.array_from_xml(example_xml.xpath('marker')),
        example: example_xml.text
      )
    end

    # def format_example(raw_examples)
    #   examples = []
      
    #   example_with_correction = raw_examples.select { |example| example.attributes['correction'] }[0]
    #   marker = example_with_correction.children.select { |child| child.name == 'marker' }[0].text
    #   sample_wrong_string = example_with_correction.children.text
    #   alternate_tokens = example_with_correction.attributes["correction"].value.split('|')

    #   alternate_tokens.length.times.with_index do |i|
    #     examples << sample_wrong_string.gsub("#{marker}", alternate_tokens[i])
    #   end

    #   examples
    # end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
