class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy cancel approve]
  after_action :days, only: [:create, :update]
  after_action :check_admin, only: [:create, :update]
  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.where(user: current_user)
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  def cancel
    @reservation.update(status:0)
    redirect_back fallback_location: reservations_path, notice: "Your reservation was successfully cancelled."
  end

  def approve
    @reservation.update(status:2)
    redirect_back fallback_location: reservations_path, notice: "The reservation was successfully approved."
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to reservations_url, notice: "Your reservation was successfully created." }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { redirect_to property_url(@reservation.property), notice: "There was a time clash with another reservation." }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url, notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def days
    @reservation.update(days: (@reservation.end_date - @reservation.start_date)/1.day)
  end
  def check_admin
    @reservation.update(status: 2) if @reservation.user.admin
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :user_id, :property_id, :guest_count, :comment, :status, :days, :is_private)
  end
end
