class FlyingTable::TableMaker
  def initialize(tables, delay_setup=false, &block)
    @tables    = tables.map{|name, cols| [name.to_s, cols]}
    @AR        = ActiveRecord
    @base      = @AR::Base
    @migration = @AR::Migration
    setup() unless delay_setup
    if block_given?
      yield(self, @AR)
      teardown()
    end
  end
  def self.create(tables)  new(tables)    end
  def self.destroy(tables) new(tables,true).teardown end

  def setup()    @base.transaction{@migration.suppress_messages{create_tables}} end
  def teardown() @base.transaction{@migration.suppress_messages{drop_tables}}   end

  # def info() "To be implemented..."

  private

  def create_tables
    @tables.each do |name, columns|
      Object.const_set(name.classify, Class.new(ActiveRecord::Base))
      @migration.create_table(name.pluralize){ |t| create_columns(t,columns)}
    end
  end

  def create_columns(t,columns) columns.each{|name,type| t.send(type,name) }    end

  def drop_tables
    @tables.each do |name, columns|
      Object.send(:remove_const, name.classify)
      @migration.drop_table(name.pluralize)
    end
  end
end