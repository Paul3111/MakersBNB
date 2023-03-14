require_relative 'owner'
class OwnerRepository
    def all
     sql = 'SELECT id, owner_name, owner_email FROM owners;'
     result_set = DatabaseConnection.exec_params(sql,[])
     owner_list = []
     result_set.each do |own|
        owned = Owner.new
        owned.id = own['id']
        owned.owner_name = own['owner_name']
        owned.owner_email = own['owner_email']
        owner_list.push(owned)
     end
     return owner_list
    end
    def find(id)
        sql = 'SELECT id, owner_name, owner_email FROM owners WHERE id = $1;'
        result_set = DatabaseConnection.exec_params(sql,[id])
        a_owner = Owner.new
        a_owner.id = result_set[0]['id']
        a_owner.owner_name = result_set[0]['owner_name']
        a_owner.owner_email = result_set[0]['owner_email']
        return a_owner
    end
    

end