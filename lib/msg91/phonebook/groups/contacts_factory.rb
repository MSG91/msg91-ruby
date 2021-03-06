require_relative 'contacts/contact'

#
module Msg91

  #
  module Phonebook

    #
    module Groups

      #
      class ContactsFactory

        attr_reader :group

        def initialize(api_client, group)
          @api_client = api_client
          @group = group
        end

        def list
          response = request('list_contact.php', group: group.id)
          raise Errors::ContactError, 'Invalid response from API' unless valid_response?(response)

          response.map do |contact|
            unless contact['contactid'].nil?
              Contacts::Contact.new(@api_client, @group, id: contact['contactid'], name: contact['name'],
                                                         number: contact['number'])
            end
          end.compact
        end

        def new(attributes = {})
          Contacts::Contact.new(@api_client, @group, attributes)
        end

        private

        def request(endpoint, request_params = {})
          raise Errors::ApiClientError, 'Invalid API client.' unless @api_client
          @api_client.request(endpoint, parameters: request_params)
        end

        def valid_response?(response)
          response.is_a?(Array) && response.last['msgType'] == 'success'
        end

      end

    end

  end

end
