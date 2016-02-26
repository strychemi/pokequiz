namespace :poke do
  desc "Scrapping for poke pics"
  task pics: [:environment] do
    pokemon_names = Pokemon.all.map { |poke| poke.name }
    scraper = PokeScraper.new

    pokemon_names.each do |pokemon|
      sleep(0.5)
      photo = Photo.new
      photo.photo_from_url( scraper.poke_pic(pokemon) )
      photo.save
      puts "Scraped and saved image for #{pokemon}"
    end
  end
end
