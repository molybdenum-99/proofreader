require_relative 'base'
require_relative 'phrase'

class Proofreader
  class Phrases < Base
    initialize_with :phrase

    def self.from_xml(phrases_xml)
      return nil if phrases_xml.nil?
      
      new(phrase: Phrase.from_xml(phrases_xml.attribute('phrase')))
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd 
# EXAMPLE USAGE: https://github.com/languagetool-org/languagetool/blob/31cb05de91c1b68ba03592b05ccd3c0df8d82e4c/languagetool-language-modules/ro/src/main/resources/org/languagetool/rules/ro/grammar.xml