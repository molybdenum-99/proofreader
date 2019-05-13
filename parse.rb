require 'nokogiri'
require 'fileutils'

class GrammarXMLParser
  def self.parse
    # 1. Open grammar.xml
    doc =      ::Nokogiri::XML(open('data/en/grammar.xml')) #NOTE: Memoize? #NOTE: Absolute path

    # 2. Designate the language that will be translated
    #language = 'English'

    # 3. Select all categories and create a file for each one (Only Wikipedia for this example)
    #doc.xpath('//category').each do |category|
    #  category_name = category.attributes['id'].value
    #  new_category_path = "proofreader/category/#{category_name.downcase}.rb" #NOTE: Check that it is downcased correctly
    #  File.open(new_category_path, 'w') unless File.exist?(new_category_path)
    #end

    #doc.xpath("//category[@id='#{category_name}']//rulegroup")

    rules =               doc.xpath("//category[@name='Wikipedia']//rule").each { |rule| p rule.attributes unless rule.attributes.empty? }
    #category_name =      category.attributes['name'] ? category.attributes['name'].value.downcase : nil
    #category_id =        category.attributes['id'] ? category.attributes['id'].value : nil
    #category_default =   category.attributes['default'] ? false : true
    #category_type =      category.attributes['type'] ? category.attributes['type'].value : nil
    #category_directory = "proofreader/api/english/#{category_name}"
    #category_filename =  "#{category_directory}/#{category_name}.rb" #NOTE: Create a class for the category itself, inheriting from class Category

    rules
  end
end

GrammarXMLParser.parse
