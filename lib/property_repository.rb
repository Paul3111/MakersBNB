require_relative './database_connection'
require_relative './property_model'

class PropertyRepository

  def all
    sql = 'SELECT * FROM properties;'
    result = DatabaseConnection.exec_params(sql, [])
    properties_list = []

    result.each do |record|
      property = Property.new
      property.id = record['id'].to_i
      property.property_name = record['property_name']
      property.property_description = record['property_description']
      property.property_price = record['property_price'].to_f
      property.property_avail_date = record['property_avail_date']
      property.property_status = record['property_status']
      property.owner_id = record['owner_id'].to_i
      properties_list << property
    end
    return properties_list
  end
  
  def find(id) # id has to be an integer
    sql = 'SELECT * FROM properties WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    record = result[0]
    property = Property.new
    property.id = record['id'].to_i
    property.property_name = record['property_name']
    property.property_description = record['property_description']
    property.property_price = record['property_price'].to_f
    property.property_avail_date = record['property_avail_date']
    property.property_status = record['property_status']
    property.owner_id = record['owner_id'].to_i
    return property
  end
  
  def create(property) # new_property is an instance of Property
    sql = 'INSERT INTO properties (property_name, property_description, property_price, property_avail_date, property_status, owner_id) VALUES ($1, $2, $3, $4, $5, $6);'
    params = [property.property_name, property.property_description,
      property.property_price, property.property_avail_date, property.property_status,
      property.owner_id]
    result = DatabaseConnection.exec_params(sql, params)
    return nil
  end
  
  def delete(id) # id has to be an integer
    # it deletes a property, returns nothing
    sql = 'DELETE FROM properties WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql, [id])
    return nil
  end
=begin
  def update(property) # property is an instance of Property
    # it updates the property attributes, returns nothing
    sql = 'UPDATE properties SET ' 
    sql += 'property_name = $1, ' if property.property_name
    sql += 'property_description = $2, ' if property.property_description
    sql += 'property_price = $3 ' if property.property_price
    sql += 'WHERE id = $4;' 
    params = [property.property_name, property.property_description, 
      property.property_price, property.id]
    result = DatabaseConnection.exec_params(sql, params)
    return nil
  end
=end

  def update(property) # property is an instance of Property
    # it updates the property attributes, returns nothing
    sql = 'UPDATE properties SET property_name = $1 WHERE id = $2;' if property.property_name
    sql = 'UPDATE properties SET property_description = $1 WHERE id = $2;' if property.property_description
    sql = 'UPDATE properties SET property_price = $1 WHERE id = $2;' if property.property_price

    if property.property_name == "" && property.property_description == ""
      sql = 'UPDATE properties SET property_price = $1 WHERE id = $2;'
      params = [property.property_price, property.id]
      return result = DatabaseConnection.exec_params(sql, params)
    elsif property.property_description == "" && property.property_price == ""
      sql = 'UPDATE properties SET property_name = $1 WHERE id = $2;'
      params = [property.property_name, property.id]
      return result = DatabaseConnection.exec_params(sql, params)
    elsif property.property_name == "" && property.property_price == ""
      sql = 'UPDATE properties SET property_description = $1 WHERE id = $2;'
      params = [property.property_description, property.id]
      return result = DatabaseConnection.exec_params(sql, params)
    end

    return nil
  end

end