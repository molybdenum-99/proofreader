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
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
