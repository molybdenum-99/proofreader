RSpec.describe Proofreader::RuleSet do
  let(:grammar_xml) do
    path = File.expand_path('../../data/en/grammar.xml', __FILE__)
    file = File.open(path)
    Nokogiri::XML(file)
  end

  it 'reads file correctly' do
    expect(grammar_xml).not_to be_nil
  end
end
