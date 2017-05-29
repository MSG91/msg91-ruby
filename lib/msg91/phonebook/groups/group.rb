require 'active_support/dependencies/autoload'

#
module Msg91

  #
  module Phonebook

    #
    module Groups

      extend ActiveSupport::Autoload
      autoload :ContactsFactory

      #
      class Group

        attr_reader :contacts

        def initialize(api_client, attributes = {})
          @api_client = api_client
          @contacts = ContactsFactory.new(api_client, self)

          whitelisted_params.each do |param|
            instance_variable_set("@#{param}", attributes[param]) if attributes[param]
            self.class.send(:attr_accessor, param)
          end
        end

        def save
          raise Errors::GroupError, 'Already created.' if persisted?
          response = request('add_group.php', group_name: params[:name])
          raise Errors::GroupError, response['msg'] if @api_client.error_response?(response)
          self.id = response['grpId']
          self
        end

        def delete
          response = request('delete_group.php', group_id: params[:id])
          raise Errors::GroupError, response['msg'] if @api_client.error_response?(response)
          true
        end

        private

        def request(endpoint, request_params = {})
          raise Errors::ApiClientError, 'Invalid API client.' unless @api_client
          @api_client.request(endpoint, parameters: request_params)
        end

        def whitelisted_params
          [:id, :count, :name]
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
