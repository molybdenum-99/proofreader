class Proofreader
  class Example
    def initialize(raw_examples)
      @examples = format_example(raw_examples)
    end

    private 

    def format_example(raw_examples)
      examples = []
      
      example_with_correction = raw_examples.select { |example| example.attributes['correction'] }[0]
      marker = example_with_correction.children.select { |child| child.name == 'marker' }[0].text
      sample_wrong_string = example_with_correction.children.text
      alternate_tokens = example_with_correction.attributes["correction"].value.split('|')

      alternate_tokens.length.times.with_index do |i|
        examples << sample_wrong_string.gsub("#{marker}", alternate_tokens[i])
      end

      examples
    end
  end
end

# TODO: Verify stability of this approach. It seems like the example with the correction attribute is the only one that matters. 
# NOTE: The rule with "Replace 'currently' with a specific date", is different. How to handle? Return the second example if correction is blank? 