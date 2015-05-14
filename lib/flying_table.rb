require "flying_table/version"
require "flying_table/table_maker"
require "active_record"

module FlyingTable
  def self.create(*args)  TableMaker.create(args)  end
  def self.destroy(*args) TableMaker.destroy(args) end
end
