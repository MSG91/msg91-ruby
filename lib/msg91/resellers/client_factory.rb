require_relative 'clients/client'

#
module Msg91

  #
  module Resellers

    #
    class ClientFactory

      def initialize(api_client)
        @api_client = api_client
      end

      def list
        response = request('client_list.php')
        raise Errors::ClientError, 'Invalid response from API' unless valid_response?(response)

        response.map do |client|
          unless client['user_pid'].nil?
            Clients::Client.new(@api_client, mapped_attribs(client))
          end
        end.compact
      end

      def new(attributes)
        Clients::Client.new(@api_client, attributes)
      end

      private

      def request(endpoint, request_params = {})
        raise Errors::ApiClientError, 'Invalid API client.' unless @api_client
        @api_client.request(endpoint, parameters: request_params)
      end

      def valid_response?(response)
        response.is_a?(Array)
      end

      def mapped_attribs(attribs)
        {
          id: attribs['user_pid'], first_name: attribs['user_fname'], last_name: attribs['user_lname'],
          name: attribs['user_uname'], mobile: attribs['user_mobno'], expiry: attribs['user_expiry'],
          email: attribs['user_email'], type: attribs['user_type'], date: attribs['user_date'],
          limit: attribs['user_slimit'], status: attribs['user_status']
        }
      end

    end

  end

end
