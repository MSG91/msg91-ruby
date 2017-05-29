require 'active_support/dependencies/autoload'

#
module Msg91

  #
  module Errors

    extend ActiveSupport::Autoload
    autoload :ClientError
    autoload :MessageError
    autoload :GroupError
    autoload :ContactError

  end

end