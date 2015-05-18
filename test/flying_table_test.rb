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
  
  def test_setup_and_teardown_instance
    @tables = FlyingTable.create(sinstance: {name: :string, created: :date})
    example = Sinstance.new(name: 'John', created: Date.today)
    assert_equal true, example.save!
    @tables.teardown
    assert_raises(NameError) {Sinstance.new()}
  end
  
  def test_block_works
    FlyingTable.with(Sample: {name: :string, created: :date}) do
      example = Sample.new(name: 'John', created: Date.today)
      assert_equal true, example.save!
      assert_equal example, Sample.where(name: 'John', created: Date.today).first
    end
    assert_raises(NameError) {Sample.new()}
  end
end