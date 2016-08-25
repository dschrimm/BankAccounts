require 'csv'
require_relative 'owner'

module Bank
  class Account
    attr_accessor :id, :balance, :date, :accounts

    def initialize(id, balance, date = nil)
      @id = id #account id
      @balance = balance #in cents
      @date = date

      unless @balance >= 0
        raise ArgumentError.new("A new account cannot be created with initial negative balance.")
      end
    end

    def add_owner(id, lname, fname, address, city, state)
      Bank::Owner.new(id, lname, fname, address, city, state)
    end

    #withdraws specified amount, will not allow withdrawl if remaining balance is less than 0.
    def withdraw(amount)
      if amount <= @balance
        @balance -= amount
      else
        puts "Your account does not contain enough to withdraw the amount requested."
      end
      return @balance
    end

    #deposits specified amount
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
      all.each do |i|
        if i.id == id
          return i
        end
      end
      puts "No account with ID ##{ id }."
    end

    ### am able to retrieve account/owner information but have not yet been able to associate them and combine stored values ###
    # creates relationship between accounts and owners
    def self.acct_with_owner
      owner_accounts = []
      CSV.read('support/account_owners.csv').each do |line|
        puts Account.find(line[0].to_i)
        puts Owner.find(line[1].to_i)
        # owner_accounts << (Account.find(line[0].to_i), Owner.find(line[1].to_i))
      end
      owner_accounts
    end

  end
end
