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

    def update_client_balance(id, sms: nil, price: nil, route: nil, direction: nil, description: nil)
      response = request('transfer_credit.php', client_id: id, sms: sms, accounttype: route, type: direction,
                                                price: price, description: description)
      raise Errors::ClientError, response['msg'] if @api_client.error_response?(response)
      true
    end

    private

    def request(endpoint, request_params = {})
      raise Errors::ApiClientError, 'Invalid API client.' unless @api_client
      @api_client.request(endpoint, parameters: request_params)
    end

  end

end
