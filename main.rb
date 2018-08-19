# frozen_string_literal: true

require 'optparse'
require_relative 'mtg/card_filter'


TMP_FILE = 'tmp/cards.dump'

options = {}
ARGV << '-h' if ARGV.empty?

option_list = OptionParser.new do |parser|
  parser.banner = 'Usage: ruby main.rb [options]'

  parser.on('-h', '--help', 'Show this help message') do
    puts parser
  end

  parser.on('-o', '--one', 'Returns a list of cards grouped by set') do
    options[:selection] = :one
  end

  parser.on('-t', '--two', 'Returns a list of Cards grouped by set, each set grouped by rarity') do
    options[:selection] = :two
  end

  parser.on('-r', '--three', 'Returns a list of cards from KTK that ONLY have the colors red AND blue') do
    options[:selection] = :three
  end

  parser.on('-f', '--four', 'Returns a list of cards from KTK that have the colors red AND blue among others') do
    options[:selection] = :four
  end

  parser.on('-d', '--delete_cache', 'Deletes Cached Cards in ./tmp directory') do
    options[:delete_dump] = true
  end
end

begin
  option_list.parse!
rescue OptionParser::InvalidOption => e
  puts e
  puts option_list
  exit 1
end

File.delete(TMP_FILE) if File.exist?(TMP_FILE) && options.dig(:delete_dump) == true

puts MTG::CardFilter.new.option(options[:selection]) unless options.dig(:selection).nil?
