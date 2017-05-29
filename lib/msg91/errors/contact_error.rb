#
module Msg91

  #
  module Errors

    #
    class ContactError < StandardError

      def initialize(msg)
        super(msg)
      end

    end

  end

end
