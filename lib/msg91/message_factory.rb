require_relative 'messages/message'

#
module Msg91

  #
  class MessageFactory

    def initialize(client)
      @client = client
    end

    def new(attributes)
      Messages::Message.new(@client, attributes)
    end

  end

end