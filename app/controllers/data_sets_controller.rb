class DataSetsController < ApplicationController
  require 'etc'

  def index
    @data_sets = DataSet.page(params[:page]).order(absolute_path: :asc)
  end

  def show
    @data_set = DataSet.find(params[:id])
  end

  # method to run Sidekiq job and update files in database
  def update_files
    UpdateFilesWorker.perform_async
    redirect_to root_path
  end
end
