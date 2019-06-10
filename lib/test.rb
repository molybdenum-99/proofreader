require_relative 'proofreader'
require_relative 'proofreader/segmenter'
require_relative 'proofreader/tokenizer'

text = "Hello world. My name is Mr. Smith. I work for the U.S. Government and I live in the U.S. I live in New York."

segments = Proofreader::Segmenter.new(text: text, language: 'en').segment
p segments

tokens = segments.map { |segment| Proofreader::Tokenizer.new(segment: segment, language: 'en').tokenize }
p tokens