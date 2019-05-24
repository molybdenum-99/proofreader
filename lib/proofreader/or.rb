require_relative 'base'

class Proofreader
  class Or < Base
    initialize_with :token

    def self.from_xml(or_xmls)
      return [] if or_xmls.nil?
      
      or_xmls.map do |or_xml|
        new(token: Token.from_xml(or_xml.xpath('token')))
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
