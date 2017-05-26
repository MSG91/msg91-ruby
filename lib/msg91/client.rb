#
module Msg91

  #
  class Client

    require 'unirest'

    API_BASE_URL = 'https://test.panel.msg91.com/api'.freeze

    attr_reader :authkey, :messages

    def initialize(authkey)
      @authkey = authkey
      @messages = MessageFactory.new(self)
    end

    def route_balance(route)
      raise Errors::MessageError, 'Invalid route' unless MessageRoute.valid_routes.include?(route)
      request('balance.php', parameters: { type: route }).to_i
    end

    def valid?
      request('validate.php') == 'Valid'
    end

    def request(endpoint, options = {})
      # Append authkey to request
      options.deep_merge!(parameters: { authkey: authkey, response: 'json' })

      response = Unirest.get("#{API_BASE_URL}/#{endpoint}", options)
      clean_response(response.body)
    end

    def error_response?(response)
      response['type'] && response['type'] == 'error'
    end

    private

    def clean_response(response)
      return response.strip if response.is_a?(String)
      response
    end

  end

end
