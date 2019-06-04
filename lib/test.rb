require_relative 'proofreader'
require_relative 'proofreader/segmenter'

text = "Hello world. My name is Mr. Smith. I work for the U.S. Government and I live in the U.S. I live in New York."

segmenter = Proofreader::Segmenter.new(text: text, language: 'en')
segmenter.tokenize
p segmenter.segments