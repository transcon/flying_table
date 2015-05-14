require 'minitest/autorun'
require 'flying_table'
require 'minitest/reporters'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestCase < MiniTest::Test
end