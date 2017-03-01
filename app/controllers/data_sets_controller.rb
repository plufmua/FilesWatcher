class DataSetsController < ApplicationController
  require 'etc'

  def index
    @data_sets = DataSet.page(params[:page])
  end

  def show
    @data_set = DataSet.find(params[:id])
  end

  # method to run Sidekiq job and update files in database
  def update_files
    UpdateFilesJob.perform_now
    redirect_to root_path
  end
end
