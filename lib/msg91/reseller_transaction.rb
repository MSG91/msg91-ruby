#
module Msg91

  #
  module ResellerTransaction

    DEBIT = 2
    CREDIT = 1

    def self.valid_directions
      [DEBIT, CREDIT]
    end

  end

end
