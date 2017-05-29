#
module Msg91

  #
  module Phonebook

    #
    module Groups

      #
      module Contacts

        #
        class Contact

          def initialize(api_client, attributes = {})
            @api_client = api_client

            whitelisted_params.each do |param|
              instance_variable_set("@#{param}", attributes[param]) if attributes[param]
              self.class.send(:attr_accessor, param)
            end
          end

          private

          def request(endpoint, request_params = {})
            raise Errors::ApiClientError, 'Invalid API client.' unless @api_client
            @api_client.request(endpoint, parameters: request_params)
          end

          def whitelisted_params
            [:id, :name, :number]
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

        end

      end

    end

  end

end
