require 'nokogiri'
require_relative 'proofreader/version'
require_relative 'proofreader/category'
require 'pry'

class Proofreader
  def initialize
    @doc = ::Nokogiri::XML(open('./data/en/grammar.xml'))
    @categories = build_categories
  end

  private 

  def build_categories
    categories = @doc.xpath('//category')

    categories.each do |category| 
      Category.new(category).call if category.attributes['name'].value == 'Wikipedia' #NOTE: Proof of concept limited to Wikipedia.
    end
  end
end

Proofreader.new
