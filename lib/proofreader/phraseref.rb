class Proofreader
  class Phraseref
    def initialize(idref:)
      @idref = idref          # Required Attribute
    end

    def self.call(phraseref_xmls)
      return [] if phraseref_xmls.empty? # NOTE: Doesn't specify maxOccurs, but see NOTE 1
    
      phraseref_xmls.map do |phraseref_xml|
        new(idref: from_xml(phraseref_xml))
      end
    end

    class << self

      private

      def from_xml(phraseref_xml)
        phraseref_xml.attribute('idref')&.value
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# NOTE 1: Example of multiple phraserefs https://github.com/languagetool-org/languagetool/blob/a000f3da2f6f874f90f686508c465b0892cb2594/languagetool-core/src/test/resources/org/languagetool/rules/xx/grammar.xml
# NOTE 2: Phraseref tags don't contain text.