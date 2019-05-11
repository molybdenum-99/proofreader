module ProofReader
  class Rule 
    def initialize
      @default = true
      @example = nil
      @filter = nil 
      @message = nil 
      @antipattern = nil
      @pattern = nil
      @regexp = nil
      @short = nil
      @suggestion = nil 
      @unique_id = nil
      @url = nil 
    end
  end

  def call#(token)
  end
end

# NOTE: Required based on minOccurs = 1
# TODO: Track required parameters
