#
module Msg91

  #
  module Messages

    #
    class Message

      def initialize(client, attributes = {})
        @client = client

        whitelisted_params.each do |param|
          instance_variable_set("@#{param}", attributes[param]) if attributes[param]
        end
      end

      def send
        request(params)
      end

      def send_unicode
        @unicode = 1
        send
      end

      def send_flash
        @flash = 1
        send
      end

      def schedule(datetime)
        @schtime = datetime
        send
      end

      def send_after(minutes)
        @afterminutes = minutes
        send
      end

      private

      def request(request_params)
        raise Errors::MessageError, 'Invalid API client. Did you initialize using `client.messages.new`?' unless @client
        response = @client.request('sendhttp.php', parameters: request_params)
        raise Errors::MessageError, response['message'] if @client.error_response?(response)
        response['message']
      end

      def whitelisted_params
        [:mobiles, :sender, :message, :route, :country, :flash, :unicode, :schtime, :afterminutes, :campaign]
      end

      def params
        result = whitelisted_params.map do |param|
          value = instance_variable_get("@#{param}")
          [param, value] unless value.nil?
        end.compact.to_h

        result[:mobiles] = result[:mobiles].join(',') if result[:mobiles].is_a?(Array)
        result
      end

    end

  end

end
