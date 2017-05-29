#
module Msg91

  #
  module Errors

    #
    class ApiClientError < StandardError

      def initialize(msg)
        super(msg)
      end

    end

  end

end
