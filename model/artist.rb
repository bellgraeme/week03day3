require_relative('sql_runner.rb')


class Artist

attr_accessor :name
attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def delete
    sql = "DELETE FROM artists WHERE id = #{id}"
    SqlRunner.run(sql)
  end

  def self.delete_all
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def save
    sql = "INSERT INTO artists 
          (name)
          VALUES
          ('#{@name}') RETURNING * ;"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def self.all
    sql ="SELECT * FROM artists"
    artist_hashes = SqlRunner.run(sql)
    return artist_hashes.map {|artist|Artist.new(artist)}
  end

 
  

  def update
      sql = "UPDATE artists SET (name) = ('#{@name}')WHERE id = #{@id};"
      SqlRunner.run(sql)
  end

  def albums
    sql = "SELECT * FROM albums WHERE artist_id = #{@id}"
    album_hashes = SqlRunner.run(sql)
    album_return = album_hashes.map {|album|Album.new(album)}
    return album_return 
    
  end


  def self.artist_id(id)
    sql = "SELECT * FROM artists
           WHERE id = (id);"
      artist_hashes = SqlRunner.run(sql)
      return artist_hashes[0]
  end


end