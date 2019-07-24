require_relative 'proofreader'
require_relative 'proofreader/input_text_parser'
require_relative 'proofreader/rule_set'

# Test rule set construction
xml = Nokogiri::XML(open('../data/en/grammar.xml'))
rule_set = Proofreader::RuleSet.new(xml: xml, rules: nil).read
p rule_set

# Test input text parsing
text = "Hello world. My name is Mr. Smith. I work for the U.S. Government and I live in the U.S. I live in New York."

input_text_parser = Proofreader::InputTextParser.new(text: text)
input_text_parser.parse

segments = input_text_parser.segments
tokens = input_text_parser.tokens

p segments
p tokens





