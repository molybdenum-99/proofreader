class Proofreader
  class Marker
    def initialize(marker:)
      @marker = marker # NOTE: Didn't find any other attributes or nested elements
    end

    def self.call(marker_xml)
      return nil if marker_xml.empty?

      new(marker: from_xml(marker_xml))
    end

    class << self

      private

      def from_xml(marker_xml)
        marker_xml.text
      end
    end
  end
end

# TODO 1: Is this a collection? Can there be more than one? Current class assumes only one. XML schema doesn't specify minOccurs or maxOccurs