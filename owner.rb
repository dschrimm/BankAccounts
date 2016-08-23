module Bank
  class Owner
    attr_accessor :name, :address, :phone

    def initialize(id, name, address, phone)
      @id = id
      @name = name
      @address = address
      @phone = phone
    end

    def owner_info
      puts "Owner's id: #{ @id }"
      puts "Owner's name: #{ @name }"
      puts "Owner's address: #{ @address }"
      puts "Owner's phone: #{ @phone }"
    end

  end
end
