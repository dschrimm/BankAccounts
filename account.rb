require 'csv'
require_relative 'owner'

module Bank
  class Account
    attr_accessor :id, :balance, :date, :accounts

    def initialize(id, balance, date = nil)
      @id = id
      @balance = balance
      @date = date

      unless @balance >= 0
        raise ArgumentError.new("A new account cannot be created with initial negative balance.")
      end
    end

    def add_owner(id, lname, fname, address, city, state)
      Bank::Owner.new(id, lname, fname, address, city, state)
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

    # return collection of Account instances
    def self.all
      accounts = []
      CSV.read('support/accounts.csv').each do |line|
        accounts << self.new(line[0].to_i, line[1].to_i, line[2])
      end
      return accounts
    end

    # returns an instance of Account where value of the id matches the parameter
    def self.find(id)
      self.all.each do |i|
        if i.id == id
          return i
        end
      end
      puts "No account with this id number."
    end

  end
end

# a = Bank::Account.new(1234, 40)
# o = a.add_owner("danielle", "909 green way", 5555555)
# o.owner_info
# a.deposit(10)
# a.balance
# a.withdraw(60)
# a.balance
# a.withdraw(30)
# a.balance
