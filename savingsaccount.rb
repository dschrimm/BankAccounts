require_relative 'account'

class SavingsAccount < Bank::Account
  attr_accessor :id, :balance, :date

  def initialize(id, balance, date)
    @id = id
    @balance = balance
    @date = date

    unless @balance >= 1000
      raise ArgumentError.new("A new account cannot be created with less than $10.")
    end
  end

  def withdraw(amount)
    transaction_fee = 200
    total_cost = amount + transaction_fee
    if total_cost <= @balance && @balance - total_cost >=1000
      @balance -= total_cost
    else
      puts "Your account does not contain enough to withdraw the amount requested. You must maintain a $10 minimum balance in your Savings Account."
    end
    return @balance
  end

  def add_interest(rate = 0.25)
    interest = @balance * rate/100
    @balance += interest
    return interest
  end
end

a = SavingsAccount.new(123, 1001, "hello")
