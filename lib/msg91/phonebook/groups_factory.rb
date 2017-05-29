require 'active_support/core_ext/hash/indifferent_access'
require_relative 'groups/group'

#
module Msg91

  #
  module Phonebook

    #
    class GroupsFactory

      def initialize(api_client)
        @api_client = api_client
      end

      def new(attributes)
        Groups::Group.new(@api_client, attributes)
      end

      def create(attributes)
        group = Groups::Group.new(@api_client, attributes)
        group.save
      end

      def list
        response = request('list_group.php')
        response.map do |attribs|
          Groups::Group.new(@api_client, attribs.with_indifferent_access)
        end
      end

      private

      def request(endpoint, request_params = {})
        raise Errors::ApiClientError, 'Invalid API client.' unless @api_client
        @api_client.request(endpoint, parameters: request_params)
      end

    end

  end

end
