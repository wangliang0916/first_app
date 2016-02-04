class EmsDataController < ApplicationController
  before_action :set_ems_datum, only: [:show, :edit, :update, :destroy]

  # GET /ems_data
  def index
    @ems_data = EmsDatum.all
  end

  # GET /ems_data/1
  def show
  end

  # GET /ems_data/new
  def new
    @ems_datum = EmsDatum.new
  end

  # GET /ems_data/1/edit
  def edit
  end

  # POST /ems_data
  def create
    @ems_datum = EmsDatum.new(ems_datum_params)

    if @ems_datum.save
      redirect_to @ems_datum, notice: 'Ems datum was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ems_data/1
  def update
    if @ems_datum.update(ems_datum_params)
      redirect_to @ems_datum, notice: 'Ems datum was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ems_data/1
  def destroy
    @ems_datum.destroy
    redirect_to ems_data_url, notice: 'Ems datum was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ems_datum
      @ems_datum = EmsDatum.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ems_datum_params
      params.require(:ems_datum).permit(:tagname, :value)
    end
end
