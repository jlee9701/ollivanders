class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about]

  def home; end

  def dashboard
    @user = current_user
    @wands = @user.wands.all
    @bookings = @user.bookings
    @received_bookings = @user.received_bookings
  end


  # def about; end
end
