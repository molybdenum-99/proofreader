class Proofreader
  class Base
    extend SmartInit

    def self.array_from_xml(elements)
      return [] if elements.nil?
      
      elements.map { |el| from_xml(el) }
    end
  end
end