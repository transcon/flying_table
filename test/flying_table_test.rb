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
    FlyingTable.create(example: {name: :string}, example2: {created: :date})
    example  = Example.new(name: 'John')
    example2 = Example2.new(created: Date.today)
    assert_equal true, example.save!
    assert_equal true, example2.save!
    FlyingTable.destroy(:example,:example2)
  end
  def test_destroys_tables
    FlyingTable.create(example: {name: :string}, example2: {created: :date})
    FlyingTable.destroy(:example, :example2)
    assert_raises(NameError) {Example.new()}
    assert_raises(NameError) {Example2.new()}
  end
end