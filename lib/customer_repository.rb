require_relative "./customer"

class CustomerRepository

  def all
    query = "SELECT * FROM customers;"
    result_set = DatabaseConnection.exec_params(query, [])
    customers = []
    result_set.each do |record|
      customer = Customer.new
      customer.id = record['id'].to_i
      customer.customer_name = record['customer_name']
      customer.customer_email = record['customer_email']
      customer.customer_password = record['customer_password']
      customers << customer
    end
    return customers
  end

  def find(id) 
    raise "ID has to be an Integer!" unless id.class == Integer
    query = "SELECT * FROM customers WHERE id = $1;"
    result_set = DatabaseConnection.exec_params(query, [id])
    record = result_set[0]
    customer = Customer.new
    customer.id = record['id'].to_i
    customer.customer_name = record['customer_name']
    customer.customer_email = record['customer_email']
    customer.customer_password = record['customer_password']
    return [customer]
  end

  def create(new_customer) 
    raise "new-customer has to be an instance of Customer!" unless new_customer.class == Customer
    query = "INSERT INTO customers (customer_name, customer_email, customer_password) VALUES ($1, $2, $3);"
    sql_params = [new_customer.customer_name, new_customer.customer_email, new_customer.customer_password]
    DatabaseConnection.exec_params(query, sql_params)
    return nil
  end

  def delete(id) 
    raise "ID has to be an Integer!" unless id.class == Integer
    query = "DELETE FROM customers WHERE id = $1;"
    DatabaseConnection.exec_params(query, [id])
    return nil
  end

  def update(customer) 
    raise "customer has to be an instance of Customer!" unless customer.class == Customer
    query = "UPDATE customers SET customer_name = $1, customer_email = $2, customer_password = $3 WHERE id = $4;"
    sql_params = [customer.customer_name, customer.customer_email, customer.customer_password, customer.id]
    DatabaseConnection.exec_params(query, sql_params)
    return nil
  end

end