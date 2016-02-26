namespace :poke do
  desc "Scrapping for poke pics"
  task pics: [:environment] do
    pokemon = Pokemon.all
    scraper = PokeScraper.new

    pokemon.each do |poke|
      sleep(0.5)
      photo = Photo.new
      photo.photo_from_url( scraper.poke_pic(poke.name) )
      photo.save
      poke.photo_id = photo.id
      poke.save
      puts "Scraped and saved image for #{poke.name}"
    end
  end
end
