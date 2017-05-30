require 'active_support/dependencies/autoload'

#
module Msg91

  extend ActiveSupport::Autoload

  autoload :Version
  autoload :ApiClient
  autoload :MessageRoute
  autoload :Errors
  autoload :MessageFactory
  autoload :PhonebookFactory
  autoload :ResellerFactory
  autoload :ResellerTransaction

end
