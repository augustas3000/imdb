require_relative('../db/sql_runner.rb')
require('pg')
require('pry')

class Movie

  attr_reader :id
  attr_accessor :title, :genre

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @genre = options["genre"]
  end

  def save
    sql = "INSERT INTO movies (title, genre)
            VALUES ($1, $2)
            RETURNING id"
    values = [@title, @genre]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM movies"
    result = SqlRunner.run(sql)
    movies_array = result.map{|movie_hash| Movie.new(movie_hash)}
    return movies_array
  end

  def update
    sql = "UPDATE movies SET (title, genre) = ($1, $2)
    WHERE id = $3"
    values = [@title, @genre, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end

  def stars
    sql = "SELECT stars.* from stars
    INNER JOIN castings on stars.id = castings.star_id
    WHERE castings.movie_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    stars_results = result.map{|star_hash| Star.new(star_hash)}
    return stars_results
  end

end
