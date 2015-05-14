class FlyingTable::TableMaker
  def self.create(tables)  new(tables).setup    end
  def self.destroy(tables) new(tables).teardown end
  def initialize(tables)
    @migration = ActiveRecord::Migration
    @tables    = tables
  end
  def create_columns(t,columns) columns.each{|name,type| t.send(type,name) }                end
  def create_tables()           @tables.each{|table| seperate_table(table)}                 end
  def drop_tables()             @tables.each{|name| drop_table(name.to_s)}                  end
  def seperate_table(table)     table.each{|name,columns| create_table(name.to_s, columns)} end
  def setup()                   @migration.suppress_messages{create_tables}                 end
  def teardown()                @migration.suppress_messages{drop_tables}                   end

  def create_table(name,columns)
    Object.const_set(name.classify, Class.new(ActiveRecord::Base))
    @migration.create_table(name.pluralize){ |t| create_columns(t,columns)}
  end
  def drop_table(name)
    Object.send(:remove_const, name.classify)
    @migration.drop_table(name.pluralize)
  end
end
