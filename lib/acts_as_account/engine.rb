module ActsAsAccount
  module Rails
    class Engine < ::Rails::Engine
      initializer 'acts_as_account.init', :before=> :load_config_initializers do
        ActiveSupport.on_load(:active_record) do
          include(ActsAsAccount::ActiveRecordExtension)
        end
      end
    end
  end
end
