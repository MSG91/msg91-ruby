require 'active_support/dependencies/autoload'

#
module Msg91

  extend ActiveSupport::Autoload

  autoload :Version
  autoload :Client
  autoload :MessageRoute
  autoload :Errors
  autoload :MessageFactory
  autoload :PhonebookFactory

end
