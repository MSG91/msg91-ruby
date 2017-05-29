#
module Msg91

  #
  module Resellers

    #
    class ClientFactory

      def initialize(api_client)
        @api_client = api_client
      end

      private

      def request(endpoint, request_params = {})
        raise Errors::ApiClientError, 'Invalid API client.' unless @api_client
        @api_client.request(endpoint, parameters: request_params)
      end

    end

  end

end
