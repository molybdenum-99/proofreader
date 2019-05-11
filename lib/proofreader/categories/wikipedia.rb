require 'nokogiri'

module ProofReader
  module Categories
    class Wikipedia < Category
      def initialize
        @id = 'WIKIPEDIA'
        @name = 'Wikipedia'
        @default = false
      end

      def call#(token)
        # Make a new Rule
        # Run the token through the Rule
        # Push result as a hash into the @errors stack, with the name of the rule and the error text
      end
    end
  end
end

#TODO: Need to do this for RuleGroups too.
