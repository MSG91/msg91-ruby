require 'active_support/dependencies/autoload'

#
module Msg91

  #
  module Errors

    extend ActiveSupport::Autoload
    autoload :ApiClientError
    autoload :MessageError
    autoload :GroupError
    autoload :ContactError
    autoload :ClientError

  end

end