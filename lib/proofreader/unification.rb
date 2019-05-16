require_relative 'equivalence'

class Proofreader
  class Unification
    def initialize(feature:, equivalence:)
      @feature = feature          # Required Attribute
      @equivalence = equivalence  # Nested Element
    end

    def self.call(unification_xmls)
      return [] if unification_xmls.empty?  # NOTE: maxOccur unbounded

      unification_xmls.map do |unification_xml|
        parsed_unification = from_xml(unification_xml)
      
        new(feature: parsed_unification[:feature], equivalence: parsed_unification[:equivalence])
      end
    end

    class << self

      private

      def from_xml(unification_xml)
        {
          feature: unification_xml.attribute('feature')&.value,
          equivalence: Equivalence.call(unification_xml.xpath('equivalence'))
        }
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd