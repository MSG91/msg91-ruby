#
module Msg91

  #
  module Errors

    #
    class ClientError < StandardError

      def initialize(msg)
        super(msg)
      end

    end

  end

end
