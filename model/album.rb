require_relative('sql_runner.rb')


class Album

attr_accessor :name, :genre
attr_reader :id, :artist_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @genre = options['options']
    @artist_id = options['artist_id'].to_i
  end

  def save
    sql = "INSERT INTO albums
          (name, genre, artist_id)
          VALUES
          ('#{@name}','#{@genre}',#{@artist_id}) RETURNING * ;"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.all
    sql ="SELECT * FROM albums"
    album_hashes = SqlRunner.run(sql)
    return album_hashes.map {|album|Album.new(album)}
  end


  def find_artist
    sql = "SELECT * FROM albums
           WHERE id = #{artist_id}"
      artist_hashes = SqlRunner.run(sql)
      artist_return = artist_hashes.map {|artist|Artist.new(artist)}
      return artist_return 
  end

  def artist
    sql = "SELECT * FROM artists
           WHERE id = #{@artist_id}"
      artist_hashes = SqlRunner.run(sql)
      artist_return = artist_hashes.map {|artist|Artist.new(artist)}
      return artist_return 
  end

  def update
    sql = "UPDATE albums SET (name, genre, artist_id) = ('#{@name}', '#{@genre}', #{@artist_id})WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM albums WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def self.album_id(id)
    sql = "SELECT * FROM albums WHERE artist_id = #{id}"
    album_hashes = SqlRunner.run(sql)
    return album_return[0]
    
  end

end