# frozen_string_literal: true

require_relative 'api_client'
require 'parallel'

module MTG
  class CardRetriever
    attr_reader :code, :colors

    def initialize(code = 'KTK', colors = %w[blue red])
      @code = code
      @colors = colors
    end

    def option(value)
      case value
      when 1
        fetch_all_cards
      when 2
        fetch_all_cards_grouped_by_rarity
      when 3
        fetch_cards_by_code_color(code, colors)
      end
    end

    private

    def all_cards
      @all_cards ||= begin
        total = []
        api_client = MTG::ApiClient.new
        total += Parallel.map((1..number_of_pages).to_a, in_processes: 10) do |page_number|
          api_client.get('cards', page: page_number)['cards']
        end
        total.flatten
      end
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

    def fetch_all_cards
      cards = cards_grouped_by_set(all_cards)
      puts cards
    rescue StandardError => error
      puts "Ups! something went wrong retrieving those cards: #{error.message}"
    end

    def fetch_all_cards_grouped_by_rarity
      cards = cards_grouped_by_set_rarity(all_cards)
      puts cards
    rescue StandardError => error
      puts "Ups! something went wrong retrieving those cards: #{error.message}"
    end

    def fetch_cards_by_code_color(code, colors)
      # pending!!!!
    end

    def cards_grouped_by_set(card_list)
      card_list.group_by { |card| card['set'] }
    end

    def cards_grouped_by_set_rarity(card_list)
      card_list.group_by { |card| [card['set'], card['rarity']] }
    end
  end
end
