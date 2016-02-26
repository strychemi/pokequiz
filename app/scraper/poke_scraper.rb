# require 'rubygems'
# require 'bundler/setup'
# require 'mechanize'
# require 'pry-byebug'

class PokeScraper
  attr_accessor :agent

  def initialize
    @agent = Mechanize.new
    @agent.pluggable_parser.default = Mechanize::Download
    @home_page = "http://pokemondb.net/pokedex/"
  end

  def poke_select(poke_name)
    @agent.get(@home_page + poke_name)
  end

  def poke_pic(poke_name)
    poke_select(poke_name).search('div.figure').children[1].attributes['src'].value
  end
end

# poke = PokeScraper.new
# byebug
# poke.poke_pic('beedrill').save
