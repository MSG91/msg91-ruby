#
module Msg91

  #
  module Errors

    #
    class GroupError < StandardError

      def initialize(msg)
        super(msg)
      end

    end

  end

end
