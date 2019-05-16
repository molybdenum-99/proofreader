class Proofreader
  class Phrases
    def initialize(phrase:)
      @phrase = phrase  # Nested Element.
    end

    def self.call(phrases_xml)
      return nil if phrases_xml.empty? # NOTE: No maxOccurs. I also checked the languagetool repo, no examples of multiple phrases tags.
      
      new(phrase: from_xml(phrases_xml))
    end

    class << self

      private

      def from_xml(phrases_xml)
        Phrase.call(phrases_xml.attribute('phrase'))
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd 
# EXAMPLE USAGE: https://github.com/languagetool-org/languagetool/blob/31cb05de91c1b68ba03592b05ccd3c0df8d82e4c/languagetool-language-modules/ro/src/main/resources/org/languagetool/rules/ro/grammar.xml