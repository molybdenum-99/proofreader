class Proofreader
  class Filter
    def initialize(filter_class:, args: )
      @class = filter_class
      @args = args
    end

    def self.call(filter_xml)
      return nil if filter_xml.empty?

      parsed_filter = from_xml(filter_xml)
      
      new(filter_class: parsed_filter[:class], args: parsed_filter[:args])
    end

    class << self

      private

      def from_xml(filter_xml)
        {
          filter_class: filter_xml.attribute('class')&.value,
          args: filter_xml.attribute('args')&.value
        }
      end
    end
  end
end

# NOTE: Only 7 uses of the filter tag in all of grammar.xml