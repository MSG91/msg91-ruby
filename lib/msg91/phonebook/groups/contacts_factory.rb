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

        def initialize(client, group)
          @client = client
          @group = group
        end

        def list
          response = request('list_contact.php', group: group.id)
          raise Errors::ContactError, 'Invalid response from API' unless valid_response?(response)

          response.map do |contact|
            unless contact['contactid'].nil?
              Contacts::Contact.new(@client, id: contact['contactid'], name: contact['name'], number: contact['number'])
            end
          end.compact
        end

        private

        def request(endpoint, request_params = {})
          raise Errors::ClientError, 'Invalid API client.' unless @client
          @client.request(endpoint, parameters: request_params)
        end

        def valid_response?(response)
          response.is_a?(Array) && response.last['msgType'] == 'success'
        end

      end

    end

  end

end
