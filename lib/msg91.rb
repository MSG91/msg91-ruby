require 'active_support/dependencies/autoload'

#
module Msg91

  extend ActiveSupport::Autoload

  autoload :Version
  autoload :Client
  autoload :Message
  autoload :MessageRoute
  autoload :Errors

end
