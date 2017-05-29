require_relative 'resellers/client_factory'

#
module Msg91

  #
  class ResellerFactory

    attr_reader :clients

    def initialize(api_client)
      @api_client = api_client
      @clients = Resellers::ClientFactory.new(api_client)
    end

    private

    def request(endpoint, request_params = {})
      raise Errors::ApiClientError, 'Invalid API client.' unless @api_client
      @api_client.request(endpoint, parameters: request_params)
    end

  end

end
