#
module Msg91

  #
  module Resellers

    #
    module Clients

      #
      class Client

        def initialize(api_client, attributes = {})
          @api_client = api_client

          whitelisted_params.each do |param|
            instance_variable_set("@#{param}", attributes[param]) if attributes[param]
            self.class.send(:attr_accessor, param)
          end
        end

        def save
          raise Errors::ClientError, 'Already created.' if persisted?
          response = request('add_client.php', api_attribs)
          raise Errors::GroupError, response['msg_arr'] if @api_client.error_response?(response)
          response
          # self.id = response['grpId']
          # self
        end

        private

        def request(endpoint, request_params = {})
          raise Errors::ApiClientError, 'Invalid API client.' unless @api_client
          @api_client.request(endpoint, parameters: request_params)
        end

        def whitelisted_params
          [:id, :first_name, :last_name, :name, :mobile, :expiry, :email, :type, :date, :limit, :status,
           :user_name, :company_name, :industry, :country_code]
        end

        def params
          whitelisted_params.map do |param|
            value = instance_variable_get("@#{param}")
            [param, value] unless value.nil?
          end.compact.to_h
        end

        def persisted?
          !id.nil?
        end

        def api_attribs
          {
            user_full_name: name, user_name: user_name, user_mobile_number: mobile, user_email: email,
            user_company_name: company_name, user_industry: industry, user_expiry: expiry,
            user_country_code: country_code
          }
        end

      end

    end

  end

end
