require 'artists_repository'

RSpec.describe ArtistRepository do

  def reset_Artists_table
    seed_sql = File.read('spec/artists_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_Artists_table
  end  

  it '' do
    repo = ArtistRepository.new
    artists = repo.all
    expect(artists.length).to eq (2)
    expect(artists.first.id).to eq ('1')
    expect(artists.first.name).to eq('Pixies') 
    expect(artists.last.id).to eq ('2')
    expect(artists.last.name).to eq('Abba') 
     
  end
end
