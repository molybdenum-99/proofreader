module ProofReader 
  class Category 
    def initialize
      @default = true
      @id = nil 
      @name = nil
      @type = nil
      @doc = ::Nokogiri::XML(open('../data/en/grammar.xml'))
      @category = @doc.xpath("//category[@name='#{@name}']")
      # @rule_groups = []
      @rules = doc.xpath("//category[@name='#{@name}']//rule")#.each { |rule| rule.attributes unless rule.attributes.empty? }
      @errors = []
    end
  end
end