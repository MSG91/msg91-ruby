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

    end

  end

end
