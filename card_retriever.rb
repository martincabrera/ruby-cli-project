require_relative 'api_client'
require 'byebug'

class CardRetriever

  attr_reader :code, :colors

  def initialize(code = 'KTK', colors = ['blue', 'red'])
    @code, @colors = code, colors
  end

  def option(value)
    case value
      when 1
        fetchAllCards
      when 2
        fetchAllCardsGroupedByRarity
      when 3
        fetchCardsByCodeColor(code, colors)
    end
  end

  private

  def all_cards
    @all_cards ||= begin
      total = []
      api_client = ApiClient.new
      (1..5).each do |page_number| #TODO!!! Use number_of_pages
        total << api_client.get('cards', { page: page_number })['cards']
      end
      total.flatten
    end
  end

  def total_card_number
    @total_card_number ||= begin
      response = ApiClient.head('cards')
      response.each_header.select { |key, value| key == 'total-count' }.flatten[1].to_i
    end
  end

  def number_of_pages
    pages, remainder = total_card_number.divmod(100)
    pages += 1 if remainder > 0
    pages
  end

  def fetchAllCards
    cards = cardsGroupedBySet(all_cards)
    puts cards
  rescue StandardError => error
    puts "Ups! something went wrong retrieving those cards: #{error.message}"
  end

  def fetchAllCardsGroupedByRarity
    cards = cardsGroupedBySetRarity(all_cards)
    puts cards
  rescue StandardError => error
    puts "Ups! something went wrong retrieving those cards: #{error.message}"
  end

  def fetchCardsByCodeColor(code, colors)

  end

  def cardsGroupedBySet(card_list)
    card_list.group_by { |card| card['set'] }
  end

  def cardsGroupedBySetRarity(card_list)
    card_list.group_by { |card| [card['set'], card['rarity']] }
  end
end
