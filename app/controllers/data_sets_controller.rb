class DataSetsController < ApplicationController

  def index
    @data_sets = DataSet.page(params[:page])
  end

  def show
    @data_set = DataSet.find(params[:id])
  end
end
