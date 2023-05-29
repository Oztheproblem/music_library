require_relative 'lib/database_connection'
require_relative 'lib/database_connection'
require_relative 'lib/artists_repository'
require_relative 'lib/album_repository'


class Application
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    @io.puts 'Welcome to the music library manager!'
    @io.puts
    @io.puts 'What would you like to do?'
    @io.puts ' 1 - List all albums'
    @io.puts ' 2 - List all artists'
    @io.puts
    @io.print 'Enter your choice: '
    choice = @io.gets.chomp.to_i

    case choice
    when 1
      list_all_albums
    when 2
      list_all_artists
    else
      @io.puts 'Invalid choice. Please try again.'
    end
  end

  private

  def list_all_albums
    albums = @album_repository.all

    @io.puts 'Here is the list of albums:'
    albums.each do |album|
      @io.puts " * #{album.id} - #{album.title}"
    end
  end

  def list_all_artists
    artists = @artist_repository.all

    @io.puts 'Here is the list of artists:'
    artists.each do |artist|
      @io.puts " * #{artist.id} - #{artist.name}"
    end
  end
end

private

  def list_all_albums
    albums = @album_repository.all
    sorted_albums = albums.sort_by { |album| album.id }

    @io.puts 'Here is the list of albums:'
    sorted_albums.each do |album|
      @io.puts " * #{album.id} - #{album.title}"
    end
  end

if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end
# # We need to give the database name to the method `connect`.
# DatabaseConnection.connect('music_library')

# artist_repository = ArtistRepository.new
# album_repository = AlbumRepository.new

# artist_repository.all.each do |artist|
#   puts "#{artist.name} is the name of the artist, #{artist.genre} is the genre"
# end

# album_repository.all.each do |album|
#   artist = artist_repository.find(album.artist_id)
#   if artist.nil?
#     puts "Artist not found for Album ID: #{album.id}"
#   else
#     puts "#{album.title} from #{artist.name} (ID: #{artist.id}) was released in the year #{album.release_year}"
#   end
# end

# app.rb