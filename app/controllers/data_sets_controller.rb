class DataSetsController < ApplicationController
  include DataSetsHelper
  require 'etc'

  def index
    @data_sets = DataSet.page(params[:page])
  end

  def show
    @data_set = DataSet.find(params[:id])
  end
  # method to update files in database
  def update_files
    update_tracked_files
    redirect_to root_path
  end
end
