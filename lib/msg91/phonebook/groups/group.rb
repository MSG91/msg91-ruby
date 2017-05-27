#
module Msg91

  #
  module Phonebook

    #
    module Groups

      #
      class Group

        def initialize(client, attributes = {})
          @client = client

          whitelisted_params.each do |param|
            instance_variable_set("@#{param}", attributes[param]) if attributes[param]
            self.class.send(:attr_accessor, param)
          end
        end

        def save
          response = request('add_group.php', params)
          raise Errors::GroupError, response['msg'] if @client.error_response?(response)
          self.id = response['grpId']
          self
        end

        def persisted?
          !id.nil?
        end

        private

        def request(endpoint, request_params = {})
          raise Errors::GroupError, 'Invalid API client.' unless @client
          @client.request(endpoint, parameters: request_params)
        end

        def whitelisted_params
          [:id, :group_name]
        end

        def params_to_exclude
          [:id]
        end

        def params
          (whitelisted_params - params_to_exclude).map do |param|
            value = instance_variable_get("@#{param}")
            [param, value] unless value.nil?
          end.compact.to_h
        end

      end

    end

  end

end
