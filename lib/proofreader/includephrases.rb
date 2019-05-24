require_relative 'base'

class Proofreader
  class Includephrases < Base
    initialize_with :phraseref, :includephrases

    def self.from_xml(includephrases_xmls)
      return [] if includephrases_xmls.nil?

      includephrases_xmls.map do |includephrases_xml|
        new(
          phraseref: Phraseref.from_xml(includephrases_xml.xpath('phraseref')),
          includephrases: includephrases.text # TODO 1
        )
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# TODO 1: See if includephrases contains text. Will need to check other languages's grammar.xml.
# NOTE: Usage of includephrases: SOURCE: https://github.com/languagetool-org/languagetool/blob/a000f3da2f6f874f90f686508c465b0892cb2594/languagetool-core/src/test/resources/org/languagetool/rules/xx/grammar.xml