class Dog
  attr_accessor :id, :name, :breed
  
  def initialize(id: nil, name:, breed:)
    @id = id
    @name = name
    @breed = breed
  end
  
  def self.create_table
    DB[:conn].execute('DROP TABLE IF EXISTS dogs')
    
    sql = <<-SQL
      CREATE TABLE dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT)
      SQL
    
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = <<-SQL
      DROP TABLE dogs
    SQL
    
    DB[:conn].execute(sql)
  end
  
  def self.new_from_db(row)
    dog = new(id: row[0], name: row[1], breed: row[2])
    dog
  end
  
  def self.find_by_name(name)
    sql = <<-SQL
      SELECT * from dogs WHERE name = ?
    SQL
    
    row = DB[:conn].execute(sql, name)
    dog = new_from_db(row)
  end
  
  def update
    sql = <<-SQL
      UPDATE 
end