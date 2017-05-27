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

      def new(name)
        Groups::Group.new(@client, name)
      end

      def create(name)
        group = Groups::Group.new(@client, name)
        group.save
      end

      def list
        request('list_group.php')
      end

      private

      def request(endpoint, request_params = {})
        raise Errors::GroupError, 'Invalid API client.' unless @client
        @client.request(endpoint, parameters: request_params)
      end

    end

  end

end
