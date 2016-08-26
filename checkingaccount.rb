require_relative 'account'

class CheckingAccount < Bank::Account
  TRANSACTION_FEE = 100 # cents
  CHECK_WITHDRAWL_FEE = 200 # cents
  MAX_OVERDRAFT = 1000 # cents

  attr_accessor :checks_remaining

  def initialize(id, balance, date)
    super(id, balance, date)
    @checks_remaining = 3
  end

  # withdrawl with transaction fee
  def withdraw(amount)
    amount += TRANSACTION_FEE
    super(amount)
  end

  # withdrawl fee activated if more than 3 checks used, overdraft limit
  def withdraw_using_check(amount)
    amount += CHECK_WITHDRAWL_FEE if @checks_remaining <= 0
    if amount <= @balance + MAX_OVERDRAFT
      @balance -= amount
      @checks_remaining -= 1
    else
      puts "Your account does not contain enough to withdraw the amount requested. You may not overdraft more than $#{ '%.2f' % (MAX_OVERDRAFT / 100.0)}."
    end
    return @balance
  end

  # resets check count to avoid transaction fee
  def reset_checks
    @checks_remaining = 3
  end
end
