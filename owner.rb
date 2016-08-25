require 'csv'

module Bank
  class Owner
    attr_accessor :id, :last_name, :first_name, :address, :city, :state

    def initialize(id, lname, fname, address, city, state)
      @id = id
      @last_name = lname
      @first_name = fname
      @address = address
      @city = city
      @state = state
    end

    def owner_info
      puts "Owner's id: #{ @id }"
      puts "Owner's name: #{ @name }"
      puts "Owner's address: #{ @address }, #{ @city }, #{ @state }"
    end

    # returns a collection of Owner instances
    def self.all
      owners = []
      CSV.read('support/owners.csv').each do |line|
        owners << Bank::Owner.new(line[0].to_i, line[1], line[2], line[3], line[4], line[5])
      end
      return owners
    end

    # returns an instance of Owner based on id parameter
    def self.find(id)
      all.each do |i|
        if i.id == id
          return i
        end
      end
      puts "There is no owner with ID ##{ id }."
    end

  end
end
