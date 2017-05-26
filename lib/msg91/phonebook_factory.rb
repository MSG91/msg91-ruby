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

  end

end
