#
module Msg91

  #
  module MessageRoute

    PROMOTIONAL = 1
    TRANSACTIONAL = 4

    def self.valid_routes
      [PROMOTIONAL, TRANSACTIONAL]
    end

  end

end
