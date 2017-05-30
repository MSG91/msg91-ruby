require_relative 'phonebook/phonebook'

#
module Msg91

  #
  class PhonebookFactory

    attr_reader :groups

    def initialize(api_client)
      @api_client = api_client
      @groups = Phonebook::GroupsFactory.new(api_client)
    end

    def delete_group(id)
      response = request('delete_group.php', group_id: id)
      raise Errors::GroupError, response['msg'] if @api_client.error_response?(response)
      true
    end

    def delete_contact(id)
      response = request('delete_contact.php', contact_id: id)
      raise Errors::ContactError, response['msg'] if @api_client.error_response?(response)
      true
    end

    private

    def request(endpoint, request_params = {})
      raise Errors::ApiClientError, 'Invalid API client.' unless @api_client
      @api_client.request(endpoint, parameters: request_params)
    end

  end

end
