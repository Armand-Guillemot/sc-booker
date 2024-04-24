class PagesController < ApplicationController
  before_action :verify_admin, only: [:admin]
  def home
    if current_user.admin? && params[:user_id].present? && User.exists?(params[:user_id])
      @selected_user = User.find(params[:user_id])
    else
      @selected_user = current_user
    end
  end

  def admin
    @reservations = Reservation.where(status: 1)
  end

  private
  def verify_admin
    redirect_back fallback_location: root_path, notice: "You must be an admin to access this page !" unless current_user.admin
  end
end
