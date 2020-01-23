require('pg')
require_relative('models/casting.rb')
require_relative('models/movie.rb')
require_relative('models/star.rb')

Casting.delete_all()
Movie.delete_all()
Star.delete_all()

movie1 = Movie.new({'title' => 'Home Alone', 'genre' => 'comedy'})
movie1.save
movie2 = Movie.new({'title' => 'Home Alone 2', 'genre' => 'comedy'})
movie2.save

star1 = Star.new({'first_name' => 'Macaulay', 'last_name' => 'Culkin'})
star1.save
star2 = Star.new({'first_name' => 'Tim', 'last_name' => 'Curry'})
star2.save

casting1 = Casting.new({'movie_id' => movie1.id, 'star_id' => star1.id, 'fee' => 999999})
casting1.save
casting2 = Casting.new({'movie_id' => movie2.id, 'star_id' => star2.id, 'fee' => 99})
casting2.save
casting3 = Casting.new({'movie_id' => movie2.id, 'star_id' => star1.id})
casting3.save

binding.pry()
nil
