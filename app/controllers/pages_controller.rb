class PagesController < ApplicationController
  def home
    if user_signed_in?
      @invites = Membership.where(user_id: current_user.id, pending: true)
    end
  end
end
