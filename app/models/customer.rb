class Customer < ApplicationRecord
  has_one :shoppingcart
  # has_many :books, through: :shoppingcarts

# Find and return each customer with 
# zero, five, or ten books in the shopping cart.
  def customers_with_specific_carts
    sql = <<-SQL
      SELECT customers.email, COUNT(shoppingcarts.customer_id) as customer_count
        FROM customers
        JOIN shoppingcarts
        ON shoppingcarts.customer_id = customers.id
        GROUP BY customers.email
        HAVING customer_count % 5 = 0
          AND customer_count <= 10
    SQL
    
    ActiveRecord::Base.connection.execute(sql).each do |id|
      puts "Email: #{id[0]}, Books: #{id[1]}"
    end

  end

  def count_customers_items
    sql = <<-SQL
      SELECT customers.email, COUNT(shoppingcarts.customer_id) as count
        FROM customers
        JOIN shoppingcarts
        ON shoppingcarts.customer_id = customers.id
        GROUP BY customers.email
    SQL

    ActiveRecord::Base.connection.execute(sql).each do |id|
      puts "Email: #{id[1]}, Items: #{id[0]}"
    end

  end

end
  