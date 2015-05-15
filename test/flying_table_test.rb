require "test_helper"
class FuzzyRecordTest < TestCase
  def test_creates_table
    FlyingTable.create(example: {name: :string, created: :date})
    example = Example.new(name: 'John', created: Date.today)
    assert_equal true, example.save!
    FlyingTable.destroy(:example)
  end
  def test_destroys_table
    FlyingTable.create(example: {name: :string, created: :date})
    FlyingTable.destroy(:example)
    assert_raises(NameError) {Example.new(name: 'John', created: Date.today)}
  end
  def test_creates_tables
    FlyingTable.create(table: {name: :string}, fable: {created: :date})
    example  = Table.new(name: 'John')
    example2 = Fable.new(created: Date.today)
    assert_equal true, example.save!
    assert_equal true, example2.save!
    FlyingTable.destroy(:table,:fable)
  end
  def test_destroys_tables
    FlyingTable.create(elbat: {name: :string}, elbaf: {created: :date})
    FlyingTable.destroy(:elbat, :elbaf)
    assert_raises(NameError) {Elbat.new()}
    assert_raises(NameError) {Elbaf.new()}
  end
end