require 'active_support/dependencies/autoload'

#
module Msg91

  #
  module Errors

    extend ActiveSupport::Autoload
    autoload :MessageError

  end

end