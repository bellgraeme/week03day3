require 'pry'
require_relative('./model/album')
require_relative('./model/artist')

Album.delete_all
Artist.delete_all

artist1 = Artist.new({'name' => 'Wacko'})
artist2 = Artist.new({'name' => 'Chilli'})

artist1.save
artist2.save

album1 =  Album.new({'name' => 'off the wall', 'genere' => 'pop', 'artist_id' => artist1.id})
album2 =  Album.new({'name' => 'blood, sex, sugar, magic', 'genere' => 'pop rock', 'artist_id' => artist2.id})

album1.save
album2.save
binding.pry
nil