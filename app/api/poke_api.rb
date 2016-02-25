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

  def get_types
    if @pokemon['types'].length == 2
      [get_type_one, get_type_two]
    else
      [get_type_one]
    end
  end

  def get_type_one
    if @pokemon['types'][0]['type']['name'].nil?
      "N/A"
    else
      @pokemon['types'][0]['type']['name']
    end
  end

  def get_type_two
    if @pokemon['types'][1]['type']['name'].nil?
      "N/A"
    else
      @pokemon['types'][1]['type']['name']
    end
  end

  def pokemon_complete
    {id: get_id, name: get_name, types: get_types}
  end
end

# api = PokeAPI.new
# api.get_pokemon('1')
# # pp api.get_name
# pp api.pokemon_complete
