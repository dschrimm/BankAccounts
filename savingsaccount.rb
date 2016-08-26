require_relative 'account'

class SavingsAccount < Bank::Account
  MINIMUM_BALANCE = 1000 # in cents
  TRANSACTION_FEE = 200 # in cents

  attr_accessor :id, :balance, :date

  def initialize(id, balance, date)
    @id = id
    @balance = balance
    @date = date

    unless @balance >= self.class::MINIMUM_BALANCE
      raise ArgumentError.new("A new account cannot be created with less than $#{ '%.2f' % (self.class::MINIMUM_BALANCE / 100.0) }.")
    end
  end

  # maintain $10 minimum balance in account including transaction fee
  def withdraw(amount)
    total_cost = amount + TRANSACTION_FEE
    if total_cost <= @balance && @balance - total_cost >=1000
      @balance -= total_cost
    else
      puts "Your account does not contain enough to withdraw the amount requested. You must maintain a $#{ '%.2f' % (self.class::MINIMUM_BALANCE / 100.0) } minimum balance in your Savings Account."
    end
    return @balance
  end

  # add interest rate as specified or default 0.25, returns interest
  def add_interest(rate = 0.25)
    interest = @balance * rate/100
    @balance += interest
    return interest
  end
end
