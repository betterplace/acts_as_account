module ActsAsAccount
  class Transfer
    attr_accessor :amount, :reference, :from, :to, :journal, :value

    def initialize(posting_1, posting_2)
      @amount, @reference = posting_2.amount, posting_2.reference
      @from, @to = posting_1.account, posting_2.account
      @journal = posting_1.journal
      @value = posting_1.value
    end

    def referencing_a?(klasse)
      reference.kind_of?(klasse)
    end

    def reverse(value = Time.now, reference = @reference, amount = @amount)
      @journal.transfer(
        amount,
        @to,
        @from,
        reference,
        value)
    end
  end
end