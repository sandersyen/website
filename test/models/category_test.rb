require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'valid category' do
    assert Category.new(name: 'Category Name').valid?
  end

  test 'category without anything' do
    assert Category.new.invalid?
  end

  test 'category with long name' do
    name = ('A'..'Z').to_a * 20
    assert Category.new(name: name).invalid?
  end
end
