require_relative 'marker'

class Proofreader
  class Example
    def initialize(correction:, type:, reason:, marker:, example:)
      @correction = correction    # Optional Attribute
      @type = type                # Optional Attribute
      @reason = reason            # Optional Attribute
      @marker = marker            # Nested Element
      @example = example          # Text of example
    end

    def self.call(examples_xml)
      return nil if examples_xml.empty?

      examples_xml.map do |example_xml|
        parsed_example = from_xml(example_xml) 

        new(correction: parsed_example[:correction], 
            type: parsed_example[:type],
            reason: parsed_example[:reason],
            marker: parsed_example[:marker],
            example: parsed_example[:example])
      end
    end

    class << self

      private

      def from_xml(example_xml)
        {
          correction: example_xml.attribute('correction')&.value,
          type: example_xml.attribute('type')&.value,
          reason: example_xml.attribute('reason')&.value,
          marker: Marker.call(example_xml.xpath('marker')),
          example: example_xml.text
        }
      end
    end
  end
end

#TODO 1: Find out if you can have multiple markers (so we rename @marker to @markers)