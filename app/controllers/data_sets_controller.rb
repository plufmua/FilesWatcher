class DataSetsController < ApplicationController

  def index
    @data_sets = DataSet.page(params[:page])
  end

  def show
    @data_set = DataSet.find(params[:id])
  end

  private

  def data_set_params
    params.require(:data_set).permit(:name, :size, :route, :creating_date, :updating_date, :owner, :group, :permissions)
  end
end
