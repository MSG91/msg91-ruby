#
module Msg91

  #
  class Client

    require 'unirest'

    API_BASE_URL = 'https://test.panel.msg91.com/api'.freeze

    attr_reader :authkey

    def initialize(authkey)
      @authkey = authkey
    end

    def check_balance(route)
      raise Errors::MessageError, 'Invalid route' unless MessageRoute.valid_routes.include?(route)
      request('balance.php', parameters: { type: route })
    end

    def valid?
      request('validate.php') == 'Valid'
    end

    private

    def request(endpoint, options = {})
      # Append authkey to request
      options.deep_merge!(parameters: { authkey: authkey })

      response = Unirest.get("#{API_BASE_URL}/#{endpoint}", options)
      response.body
    end

  end

end
