class Proofreader
  class Example
    def initialize(correction:, type:, reason:, markers:)
      @correction = correction
      @type = type
      @reason = reason
      @markers = markers
    end

    def self.call(examples_xml)
      return nil if examples_xml.empty?

      examples_xml.map do |example_xml|
        parsed_example = from_xml(example_xml) 

        new(correction: parsed_example[:correction], 
            type: parsed_example[:type],
            reason: parsed_example[:reason],
            markers: parsed_example[:markers])
      end
    end

    class << self

      private

      def from_xml(example_xml)
        {
          correction: example_xml.attribute('correction')&.value,
          type: example_xml.attribute('type')&.value,
          reason: example_xml.attribute('reason')&.value,
          markers: nil #Marker.call(example_xml.xpath('marker'))
        }
      end
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

# TODO 1: Use is_a? to check if we have one example or many.
# TODO 3: Finish Marker class
# TODO 3: The rule with "Replace 'currently' with a specific date", is different. How to handle? Return the second example if correction is blank? 