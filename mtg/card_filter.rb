# frozen_string_literal: true

require_relative 'card_retriever'

module MTG
  class CardFilter
    def option(value) # rubocop:disable Metrics/MethodLength
      case value
      when :one
        cards_grouped_by_set
      when :two
        cards_grouped_by_set_rarity
      when :three
        cards_with_code_only_colors('KTK', %w[Red Blue])
      when :four
        cards_with_code_colors('KTK', %w[Red Blue])
      end
    rescue StandardError => error
      puts "Ups! something went wrong retrieving those cards: #{error.message}"
    end

    private

    def cards_list
      MTG::CardRetriever.cards
    end

    def cards_grouped_by_set
      cards_list.group_by { |card| card['set'] }
    end

    def cards_grouped_by_set_rarity
      cards_list.group_by { |card| [card['set'], card['rarity']] }
    end

    def cards_with_code_only_colors(code, colors)
      cards_list.select { |card| card['set'] == code }.select do |card|
        card.key?('colors') && card['colors'].sort == colors.sort
      end
    end

    def cards_with_code_colors(code, colors)
      cards_list.select { |card| card['set'] == code }.select do |card|
        card.key?('colors') && (colors - card['colors']).empty?
      end
    end
  end
end
