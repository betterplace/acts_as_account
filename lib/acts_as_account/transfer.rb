module ActsAsAccount
  class Transfer
    attr_accessor :amount, :reference, :from, :to, :journal
  
    def initialize(posting_1, posting_2)
      @amount, @reference = posting_2.amount, posting_2.reference
      @from, @to = posting_1.account, posting_2.account
      @journal = posting_1.journal
    end
  
    def referencing_a?(klasse)
      reference.kind_of?(klasse)
    end
    
    def reverse(reference = @reference, valuta = Time.now)
      @journal.transfer(
        @amount,
        @to,
        @from,
        reference,
        valuta)
    end
  end
end