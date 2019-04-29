RSpec.describe SmartPensionTest::LogAnalyzer do
  let(:parsed_log_data) { [] }
  let(:log_analyzer) { described_class.new(parsed_log_data) }

  it 'takes parsed log file as an initialize argument' do
    described_class.new([])
  end

  describe '#most_page_views' do

    it 'is an collection' do
      expect(log_analyzer.most_page_views).to be_kind_of Enumerable
    end

    context 'log contains one item' do
      let(:parsed_log_data) { [double('LogItem', path: 'a', ip_address: 1)] }

      it 'contains one item with path a and visit count 1' do
        expect(log_analyzer.most_page_views).to match([path: 'a', visit_count: 1])
      end
    end

    context 'when log contains two different items' do
      let(:parsed_log_data) do
        [
          double('LogItem', path: 'a', ip_address: '1'),
          double('LogItem', path: 'b', ip_address: '2')
        ]
      end

      it 'has two items with different path and visit count = 1' do
        expect(log_analyzer.most_page_views).to match(
          [
            { path: "a", visit_count: 1 },
            { path: "b", visit_count: 1 }
          ]
        )
      end
    end
  end

end
