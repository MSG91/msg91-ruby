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
          request(group_name: name)
        end

        private

        def request(request_params)
          raise Errors::GroupError, 'Invalid API client. Did you initialize using `client.phonebook.groups.new`?' unless @client
          response = @client.request('add_group.php', parameters: request_params)
          raise Errors::GroupError, response['msg'] if @client.error_response?(response)
          response['grpId']
        end

      end

    end

  end

end
