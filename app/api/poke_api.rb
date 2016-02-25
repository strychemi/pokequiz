require 'httparty'
require 'pp'

class PokeAPI

  def initialize
    @url = 'http://pokeapi.co/api/v2/'
    @pokemon = {}
  end

  def get_pokemon(poke_name)
    @pokemon = HTTParty.get(@url + "pokemon/" + poke_name).parsed_response
  end

  def get_name
    @pokemon['name']
  end

  def get_id
    @pokemon['id']
  end

  def get_type_one
    @pokemon['types'][1]['type']['name']
  end

  def get_type_two
    @pokemon['types'][0]['type']['name']
  end

  def pokemon_complete
    {id: get_id, name: get_name, types: [get_type_one, get_type_two]}
  end
end

