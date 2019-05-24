require 'nokogiri'
require 'smart_init'
require_relative 'proofreader/version'
require_relative 'proofreader/rules'
require 'pry'

class Proofreader
  attr_reader :rules

  def initialize
    @doc = ::Nokogiri::XML(open('./data/en/grammar.xml'))
    @rules = build_rules # Nested Element
  end

  private 

  def build_rules
    Rules.from_xml(@doc.xpath('rules'))
  end
end

proofreader = Proofreader.new # NOTE: In the future we can setup for 'en', but only parsing English for now
pp proofreader.rules

# XML Schema Sources:
# Part 1: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/rules.xsd
# Part 2: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd

# MASTER TODO:
# TODO 1: How to handle default attributes. Some say 'off', others say 'no', etc. Should we make these boolean false? Or keep them as strings that say 'no', 'yes', 'off', 'on', etc.?
# TODO 2: How many namespaces? So far everything is under Proofreader. If a tag is only nested under a tag other than proofreader, should we namespace under it? Proofreader::Pattern::Token for example?
# TODO 3: The Proofreaer::And, Proofreader::Or classes. Do they make sense? I wanted to map exactly to the XML schemas.
# TODO 4: There are grammar AND disambiguator rules. EX from Portuguese: https://github.com/languagetool-org/languagetool/blob/4d5b1c323a37990ea2ee583c3c4d58e9d5f7d555/languagetool-language-modules/pt/src/main/resources/org/languagetool/resource/pt/disambiguation.xml
# TODO 5: Which require_relatices are absolutely necessary.

# Final
# Go back and list all default attributes in the notes in each initializer
# Check TODOS inside files