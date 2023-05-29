# ARTIST Model and Repository Classes Design Recipe
## 1. Design and create the Table
If the table is already created in the database, you can skip this step.

## 2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

# -- # EXAMPLE
-- (file: spec/artists_seeds.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

# TRUNCATE TABLE artisits
 RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO artists (name, genre) VALUES ('Pixies', 'Rock');
INSERT INTO artists (name, genre) VALUES ('Abba', 'Pop');  

psql -h 127.0.0.1 music_library_test < artists_seeds.sql
## 3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# EXAMPLE
# Table name: artisits


# Model class
# (in lib/Artist.rb)
class Artist
end

# Repository class
# (in lib/Artist_repository.rb)
class ArtistRepository
end
## 4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: artisits


# Model class
# (in lib/Artist.rb)

class Artist
  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :genre
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# Artist = Artist.new
# Artist.name = 'Jo'
# Artist.name
You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

## 5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: artisits


# Repository class
# (in lib/Artist_repository.rb)

class ArtistRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, genre FROM artisits
    ;

    # Returns an array of Artist objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, genre FROM artisits
     WHERE id = $1;

    # Returns a single Artist object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(Artist)
  # end

  # def update(Artist)
  # end

  # def delete(Artist)
  # end
end
## 6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all artisits


repo = ArtistRepository.new

artists = repo.all
artists.length # =>  2
artists.id # =>  1
artists.first.name # =>  'Pixies'
artisits

# 2
# Get a single Artist

repo = ArtistRepository.new

Artist = repo.find(1)

Artist.id # =>  1
Artist.name # =>  'David'
Artist.genre # =>  'April 2022'

# Add more examples for each method
Encode this example as a test.

## 7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/Artist_repository_spec.rb

def reset_Artists_table
  seed_sql = File.read('spec/seeds_Artists.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'artisits
  ' })
  connection.exec(seed_sql)
end

describe ArtistRepository do
  before(:each) do 
    reset_Artists_table
  end

  # (your tests will go here).
end
## 8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour. 