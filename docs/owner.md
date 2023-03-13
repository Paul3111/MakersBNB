
context "test all method" do
    it "returns all the owner names" do
        repo = OwnerRepository.new
        owner = repo.all
        @names = []
        owner.each do |name|
            @names.push(name.owner_name)
        end
        expect(@names).to eq ["owner1","owner2","owner3]
    end
    it "returns "all emails for the owners" do
        repo = OwnerRepository.new
        owner = repo.all
        @email = []
        owner.each do |the_email|
            @names.push(the_email.owner_email)
        end
        expect(@email).to eq ["owner1@test.com","owner2@test.com",owner3@test.com]
    end
end
context "test find method" do
    it "finds the owner name" do
        repo = OwnerRepository.new
        owner = repo.find(2)
        expect(owner.owner_name).to eq("owner1")
        expect(owner.owner_email).to eq("owner1@test.com")
    end

end 