module ActsAsAccount
  class Configuration
    attr_accessor :persist_attributes_on_account

    def initialize
      # default values
      @persist_attributes_on_account = true
    end
  end
end
