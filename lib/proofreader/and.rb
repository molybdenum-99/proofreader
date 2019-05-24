require_relative 'base'

class Proofreader
  class And < Base
    initialize_with :token, :marker

    def self.from_xml(and_xmls)
      return [] if and_xmls.nil?
      
      and_xmls.map do |and_xml|
        new(
          token: Token.from_xml(and_xml.xpath('token')),
          marker: Marker.from_xml(and_xml.xpath('marker'))
        )
      end
    end
  end
end


# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd