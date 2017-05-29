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
          self.class.send(:attr_accessor, param)
        end
      end

      def send
        raise Errors::MessageError, 'Already sent.' if persisted?
        response = request('sendhttp.php', params)
        raise Errors::MessageError, response['message'] if @client.error_response?(response)
        self.id = response['message']
        self
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

      def request(endpoint, request_params = {})
        raise Errors::ClientError, 'Invalid API client.' unless @client
        @client.request(endpoint, parameters: request_params)
      end

      def whitelisted_params
        [:id, :mobiles, :sender, :message, :route, :country, :flash, :unicode, :schtime, :afterminutes, :campaign]
      end

      def params_to_exclude
        [:id]
      end

      def params
        result = (whitelisted_params - params_to_exclude).map do |param|
          value = instance_variable_get("@#{param}")
          [param, value] unless value.nil?
        end.compact.to_h

        result[:mobiles] = result[:mobiles].join(',') if result[:mobiles].is_a?(Array)
        result
      end

      def persisted?
        !id.nil?
      end

    end

  end

end
