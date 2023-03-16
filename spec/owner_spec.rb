require 'owner_repository'
require 'owner'

def reset_tables
  seed_sql = File.read('spec/seeds_test.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

RSpec.describe OwnerRepository do
  before(:each) do
    reset_tables
  end

  context "test all method" do
    it "returns all the owner names" do
      repo = OwnerRepository.new
      owners = repo.all #this tests the all method specifically the first id owner name and email
      expect(owners[0].id).to eq ("1")
      expect(owners[0].owner_name).to eq ("Owner 1")
      expect(owners[0].owner_email).to eq ("owner1@example.com")
    end
  end

  context "test all method" do
    it "returns all the owner names" do
        repo = OwnerRepository.new
        owners = repo.all #this tests the all method specifically the first id owner name and email
        expect(owners[0].id).to eq ("1")
        expect(owners[0].owner_name).to eq ("Owner 1")
        expect(owners[0].owner_email).to eq ("owner1@example.com")
    end
  
    it "returns all emails for the owners" do
      repo = OwnerRepository.new
      owner = repo.all
      @email = []
      owner.each do |the_email|
          @email.push(the_email.owner_email)
      end
      expect(@email).to eq ["owner1@example.com","owner2@example.com","owner3@example.com"]
    end
  end

  context "test find method" do
    it "finds the owner name" do
       repo = OwnerRepository.new
       owner = repo.find(1)
       expect(owner.owner_name).to eq("Owner 1")
       expect(owner.owner_email).to eq("owner1@example.com")
    end
    
    it "finds the owner name" do
       repo = OwnerRepository.new
       owner = repo.find(2)
       expect(owner.owner_name).to eq("Owner 2")
       expect(owner.owner_email).to eq("owner2@example.com")
    end
  end
  
  context "test find method" do
    it "finds the owner name" do
      repo = OwnerRepository.new
      owner = repo.find(1)
      expect(owner.owner_name).to eq("Owner 1")
      expect(owner.owner_email).to eq("owner1@example.com")
    end

    it "finds the owner name" do
      repo = OwnerRepository.new
      owner = repo.find(2)
      expect(owner.owner_name).to eq("Owner 2")
      expect(owner.owner_email).to eq("owner2@example.com")
    end

    it "finds the owner name" do
      repo = OwnerRepository.new
      owner = repo.find(3)
      expect(owner.owner_name).to eq("Owner 3")
      expect(owner.owner_email).to eq("owner3@example.com")
    end
  end 
end