require_relative 'messages/message'

#
module Msg91

  #
  class MessageFactory

    def initialize(api_client)
      @api_client = api_client
    end

    def new(attributes)
      Messages::Message.new(@api_client, attributes)
    end

  end

end