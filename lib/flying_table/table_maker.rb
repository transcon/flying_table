class FlyingTable::TableMaker
  def self.create(tables)  new(tables).setup    end
  def self.destroy(tables) new(tables).teardown end
  def initialize(tables)
    @AR        = ActiveRecord
    @base      = @AR::Base
    @migration = @AR::Migration
  end
  def setup()             @base.transaction{@migration.suppress_messages{create_tables}}    end
  def teardown()          @base.transaction{@migration.suppress_messages{drop_tables}}      end

  private
  def create_columns(t,columns) columns.each{|name,type| t.send(type,name) }                end
  def create_tables()           @tables.each{|name,cols| create_table(name.to_s, cols)}     end
  def drop_tables()             @tables.each{|name| drop_table(name.to_s)}                  end

  def create_table(name,columns)
    Object.const_set(name.classify, Class.new(ActiveRecord::Base))
    @migration.create_table(name.pluralize){ |t| create_columns(t,columns)}
  end
  def drop_table(name)
    Object.send(:remove_const, name.classify)
    @migration.drop_table(name.pluralize)
  end
end
