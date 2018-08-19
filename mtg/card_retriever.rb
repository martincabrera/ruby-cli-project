# frozen_string_literal: true

require_relative 'api_client'
require 'parallel'

module MTG
  class CardRetriever
    TMP_FILE = 'tmp/cards.dump'

    def self.cards
      new.send(:cards)
    end

    private

    def cards
      return file_content if file_not_empty
      cards_and_save
    end

    def api_cards
      total = []
      api_client = MTG::ApiClient.new
      total += Parallel.map((1..2).to_a, in_processes: 10) do |page_number| # TODO: Cambiar 2 por number_of_pages
        api_client.get('cards', page: page_number)['cards']
      end
      total.flatten
    end

    def total_card_number
      @total_card_number ||= begin
        response = MTG::ApiClient.head('cards')
        response.each_header.select { |key, _value| key == 'total-count' }.flatten[1].to_i
      end
    end

    def number_of_pages
      pages, remainder = total_card_number.divmod(100)
      pages += 1 if remainder.positive?
      pages
    end

    def cards_and_save
      cards = api_cards
      save_content_to_file(cards)
      cards
    end

    def file_not_empty
      File.exist?(TMP_FILE) && !File.zero?(TMP_FILE)
    end

    def file_content
      File.read(TMP_FILE)
    end

    def save_content_to_file(file_content)
      File.write(TMP_FILE, file_content)
    end
  end
end
