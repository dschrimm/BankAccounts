require_relative 'owner'

module Bank
  class Account
    attr_accessor :id, :balance

    def initialize(id, balance)
      @id = id
      @balance = balance

      unless @balance >= 0
        raise ArgumentError.new("A new account cannot be created with initial negative balance.")
      end
    end

    def add_owner(name, address, phone)
      Bank::Owner.new(@id, name, address, phone)
    end

    def withdraw(amount)
      if amount <= @balance
        @balance -= amount
        return @balance
      else
        puts "Your account does not contain enough to withdraw the amount requested."
        return @balance
      end
    end

    def deposit(amount)
      @balance += amount
      return @balance
    end

  end
end

# a = Bank::Account.new(1234, 40)
# o = a.add_owner("danielle", "909 green way", 5555555)
# o.owner_info
