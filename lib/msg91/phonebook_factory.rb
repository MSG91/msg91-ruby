require_relative 'phonebook/phonebook'

#
module Msg91

  #
  class PhonebookFactory

    attr_reader :groups

    def initialize(client)
      @client = client
      @groups = Phonebook::GroupsFactory.new(client)
    end

    def delete_group(id)
      response = request('delete_group.php', group_id: id)
      raise Errors::GroupError, response['msg'] if @client.error_response?(response)
      true
    end

    private

    def request(endpoint, request_params = {})
      raise Errors::ClientError, 'Invalid API client.' unless @client
      @client.request(endpoint, parameters: request_params)
    end

  end

end
