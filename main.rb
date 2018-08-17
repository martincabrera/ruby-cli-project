# frozen_string_literal: true

require 'optparse'

options = {}
ARGV << '-h' if ARGV.empty?

option_list = OptionParser.new do |parser|
  parser.banner = 'Usage: ruby main.rb [options]'

  parser.on('-h', '--help', 'Show this help message') do
    puts parser
  end

  parser.on('-o', '--one', 'Returns a list of cards grouped by set') do
    options[:selection] = 1
  end

  parser.on('-t', '--two', 'Returns a list of Cards grouped by set, each set grouped by rarity') do
    options[:selection] = 2
  end

  parser.on('-h', '--three', 'Returns a list of cards from KTK that ONLY have the colors red AND blue') do
    options[:selection] = 3
    endd
  end
end

begin
  option_list.parse!
rescue OptionParser::InvalidOption => e
  puts e
  puts option_list
  exit 1
end

case options[:selection]
when 1
  puts 'Hola'
when 2
  puts 'Adiós'
when 3
  puts 'Ni hola ni adiós'
end
