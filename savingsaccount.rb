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

  # maintain minimum balance in account including transaction fee
  def withdraw(amount)
    amount += TRANSACTION_FEE
    super(amount)
  end

  # add interest rate as specified or default, returns interest
  def add_interest(rate = 0.25)
    interest = @balance * rate/100
    @balance += interest
    return interest
  end
end
