require 'pry'
class Pokemon
  attr_accessor :id, :name, :type, :db, :hp
  @@hp_has_been_added = false

  def initialize(id:, name:, type:, db:, hp: 60)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db = db
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?);", name, type)
  end

  def self.find(id, db)
    #name_prep = db.prepare("SELECT name FROM pokemon WHERE id = ?;")
    #name = name_prep.execute("#{id}")
    #type_prep = db.prepare("SELECT type FROM pokemon WHERE id = ?;")
    #type = type_prep.execute("#{id}")

    name = db.execute("SELECT name FROM pokemon WHERE id = ?;", id).flatten.first
    type = db.execute("SELECT type FROM pokemon WHERE id = ?;", id).flatten.first
    hp = @@hp_has_been_added ? db.execute("SELECT hp FROM pokemon WHERE id = ?;", id).flatten.first : 60
    self.new(id: id, name: name, type: type, db: db, hp: hp)
  end

  def alter_hp(hp, db)
    @@hp_has_been_added = true
    @hp = hp
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?;", hp, id)
  end
end
