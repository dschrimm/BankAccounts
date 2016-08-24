require 'csv'

module Bank
  class Owner
    attr_accessor :name, :address, :phone

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
        owners << Bank::Owner.new(line[0], line[1], line[2], line[3], line[4], line[5])
      end
      return owners
    end

  end
end
