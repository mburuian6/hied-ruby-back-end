module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # TODO: Implement security
    # identified_by :current_bidder
    #
    # def connect
    #   self.current_bidder = find_verified_user
    # end
    #
    # private
    #
    # def find_verified_user
    #   if (verified_user = current_user)
    #     verified_user
    #   else
    #     reject_unauthorized_connection
    #   end
    # end
  end
end
