class Pokemon
  attr_accessor :id, :name, :type, :db, :hp
  def initialize(id, name, type, db, hp = 60)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db = db
  end

  def self.save(name, type, db)
    @db.execute("INSERT INTO pokemon (name, type) VALUES (#{name}, #{type});")
  end

  def self.find(id, db)
    name = @db.execute("SELECT name FROM pokemon WHERE id = #{id};")
    type = @db.execute("SELECT type FROM pokemon WHERE id = #{id};")
    hp = @db.execute("SELECT hp FROM pokemon WHERE id = #{id};")
    self.new(id, name, type, db)
  end

  def alter_hp(hp, db)
    @hp = hp
    @db.execute("UPDATE TABLE pokemon SET hp = #{hp} WHERE id = #{id};")
  end
end
