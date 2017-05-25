#
module Msg91

  #
  module Errors

    #
    class MessageError < StandardError

      def initialize(msg)
        super(msg)
      end

    end

  end

end
