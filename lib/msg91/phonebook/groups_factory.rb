require 'active_support/core_ext/hash/indifferent_access'
require_relative 'groups/group'

#
module Msg91

  #
  module Phonebook

    #
    class GroupsFactory

      def initialize(client)
        @client = client
      end

      def new(attributes)
        Groups::Group.new(@client, attributes)
      end

      def create(attributes)
        group = Groups::Group.new(@client, attributes)
        group.save
      end

      def list
        response = request('list_group.php')
        response.map do |attribs|
          Groups::Group.new(@client, attribs.with_indifferent_access)
        end
      end

      private

      def request(endpoint, request_params = {})
        raise Errors::GroupError, 'Invalid API client.' unless @client
        @client.request(endpoint, parameters: request_params)
      end

    end

  end

end
