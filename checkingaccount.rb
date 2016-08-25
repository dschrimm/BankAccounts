require_relative 'account'

class CheckingAccount < Bank::Account
  attr_accessor :checks_remaining

  def initialize(id, balance, date)
    super(id, balance, date)
    @checks_remaining = 3
  end

  # withdrawl with $1 fee, balance cannot go below $0
  def withdraw(amount)
    transaction_fee = 100 #in cents
    total_cost = amount + transaction_fee
    if total_cost <= @balance
      @balance -= total_cost
    else
      puts "Your account does not contain enough to withdraw the amount requested."
    end
    return @balance
  end

  # withdrawl with $2 fee if more than 3 checks used, cannot withdraw more than $10 below current balance
  def withdraw_using_check(amount)
    amount += 200 if @checks_remaining <= 0
    if amount <= @balance + 1000
      @balance -= amount
      @checks_remaining -= 1
    else
      puts "Your account does not contain enough to withdraw the amount requested. You may not overdraft more than $10."
    end
    return @balance
  end

  # resets check count to avoid $2 transaction fee
  def reset_checks
    @checks_remaining = 3
  end
end
