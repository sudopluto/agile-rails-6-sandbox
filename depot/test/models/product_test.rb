require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "product attributes must not be be empty" do 
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do 
    product = Product.new(title:       "fruit",
                          description: "funky and fresh",
                          image_url:   "example.com/image.jpg")

    product.price = -1

    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]

    product.price = 0

    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
      product.errors[:price]

    product.price = 1
    assert product.valid?

  end

  def new_product(image_url)
    Product.new(title:       "fruit",
                description: "funky and fresh",
                image_url: image_url,
                price:        3.50)
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://example.com/test/image.jpg }
    bad = %w{ fred.txt fred.cpp fred.rb FRED.JPG.txt http://example.com/test/ }

    ok.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} should be valid url"
    end

    bad.each do |image_url|
      assert new_product(image_url).invalid?, "#{image_url} should be invalid url"
    end
  end

  test "unique title" do 
    product = Product.new(title:       products(:fruit).title,
                description: "funky and fresh",
                image_url: "banana.jpg",
                price:        3.50)

    assert product.invalid?

    assert_equal ["has already been taken"], product.errors[:title]
  end
    
end
