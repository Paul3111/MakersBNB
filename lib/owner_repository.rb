require_relative 'owner'
class OwnerRepository
  def all
    sql = 'SELECT id, owner_name, owner_email, owner_password FROM owners;'
    result_set = DatabaseConnection.exec_params(sql,[])
    owner_list = []
    result_set.each do |own|
      owned = Owner.new
      owned.id = own['id']
      owned.owner_name = own['owner_name']
      owned.owner_email = own['owner_email']
      owned.owner_password = own['owner_password']
      owner_list.push(owned)
    end
      return owner_list
  end

  def find(id)
    sql = 'SELECT id, owner_name, owner_email, owner_password FROM owners WHERE id = $1;'
    result_set = DatabaseConnection.exec_params(sql,[id])
    a_owner = Owner.new
    a_owner.id = result_set[0]['id']
    a_owner.owner_name = result_set[0]['owner_name']
    a_owner.owner_email = result_set[0]['owner_email']
    a_owner.owner_password = result_set[0]['owner_password']
    return a_owner
  end

  def create(new_owner)
    sql = "INSERT INTO owners (owner_name, owner_email, owner_password) VALUES ($1, $2, $3);"
    sql_params = [new_owner.owner_name, new_owner.owner_email, new_owner.owner_password]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end
    

end