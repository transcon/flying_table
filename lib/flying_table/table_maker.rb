# To think about:
#   - [ ] Reimplement interface according to FlyingTable2 below
#   - [ ] put whole block under one transaction so the block can fail and keep it in state
#   - [ ] use temporary tables in the database itself when available for isolation and safety
#
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


=begin

class FlyingTable2
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

  def setup()    @base.transaction{@migration.suppress_messages{create_tables}} end
  def teardown() @base.transaction{@migration.suppress_messages{drop_tables}}   end

  def info() "To be implemented..."

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



# Example:
#

FlyingTable2.new(t1: {c1: :t1, c2: :t2}) {|ft|
  # do stuff that assumes table 't1' exists
  ft.info
}


module FlyingTables
  def self.with(tables,&block) FlyingTable2.new(tables, &block) end
end


FlyingTables.with(t1: {c1: :type1}) do

end



=end
