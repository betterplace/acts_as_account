module ActsAsAccount
  class Configuration
    attr_accessor :persist_balance, :persist_postings_count
  end

  def initialize
    # default values
    @persist_balance = true
    @persist_postings_count = true
  end
end
