class Proofreader
  class Url
    def initialize(url:)
      @url = url
    end

    def self.call(url_xml)
      return nil if url_xml.empty?

      new(url: from_xml(url_xml))
    end

    class << self 
      
      private

      def from_xml(url_xml)
        url_xml.text
      end
    end
  end
end