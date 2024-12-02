RSpec.describe Proofreader::RuleSet do
  let(:grammar_xml) do
    path = File.expand_path('../../data/en/grammar.xml', __FILE__)
    file = File.read(path)
    Nokogiri::Slop(file)
  end

  it 'has rule categories' do
    expect(grammar_xml.rules.category.size).to eq(13)
  end

  let(:token) {
    grammar_xml.rules.category.first.rulegroup.first.rule.pattern.token.text
  }

  it 'can provide very deep nested element' do
    expect(token).to be_a String
  end
end
