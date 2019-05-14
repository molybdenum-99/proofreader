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
    categories_xml = @doc.xpath('//category')

    categories_xml.map do |category_xml|
      Category.call(category_xml) if category_xml.attributes['name'].value == 'Wikipedia'
    end
  end
end

Proofreader.new

# TODO: Use XML Documentation to ensure all attributes are accounted for for each tag.
# TODO: Something better than 'build_categories'?
