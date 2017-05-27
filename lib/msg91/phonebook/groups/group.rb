#
module Msg91

  #
  module Phonebook

    #
    module Groups

      #
      class Group

        attr_accessor :name

        def initialize(client, name)
          @client = client
          @name = name
        end

        def save
          response = request('add_group.php', group_name: name)
          raise Errors::GroupError, response['msg'] if @client.error_response?(response)
          response['grpId']
        end

        private

        def request(endpoint, request_params = {})
          raise Errors::GroupError, 'Invalid API client.' unless @client
          @client.request(endpoint, parameters: request_params)
        end

      end

    end

  end

end
