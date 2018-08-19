# frozen_string_literal: true

require 'card_retriever'
require 'byebug'

describe MTG::CardRetriever do
  let(:cards_content) { 'This is my cards content' }

  context 'When NO cached cards file exists in tmp' do
    before do
      allow_any_instance_of(MTG::CardRetriever).to receive(:file_not_empty).and_return(false)
      allow_any_instance_of(MTG::CardRetriever).to receive(:api_cards).and_return(cards_content)
      allow_any_instance_of(MTG::CardRetriever).to receive(:save_content_to_file)
    end

    it 'returns cards content' do
      cards = described_class.cards
      expect(cards).to eq cards_content
    end

    it 'saves cards content in tmp' do
      card_retriever = described_class.new
      card_retriever.send(:cards)
      expect(card_retriever).to have_received(:save_content_to_file)
    end
  end

  context 'When cached cards file exists in tmp' do
    before do
      allow_any_instance_of(MTG::CardRetriever).to receive(:file_not_empty).and_return(true)
    end

    it 'returns cards content' do
      allow_any_instance_of(MTG::CardRetriever).to receive(:file_content).and_return(cards_content)
      cards = described_class.cards
      expect(cards).to eq cards_content
    end
  end
end
