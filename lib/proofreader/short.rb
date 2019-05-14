class Proofreader
  class Short
    def initialize(short: )
      @short = short
    end

    def self.call(short_xml)
      return nil if short_xml.empty?

      new(short: from_xml(short_xml))
    end

    class << self 
      
      private

      def from_xml(short_xml)
        short_xml.text
      end
    end
  end
end

# TODO 1: Check against master XML documentation about what all attributes can live on short.