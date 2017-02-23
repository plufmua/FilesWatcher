class DataSetsController < ApplicationController

  def index
    @data_sets = DataSet.page(params[:page])
  end

  def show
    @data_set = DataSet.find(params[:id])
  end
  # method to update files in database
  def update_files
    path = "/home/zharko/Untitled Folder"
    if Dir.exist? path
      Dir.foreach(path) { |file|
        if File.file?(path + '/' + file)
          puts file
          puts File.size(path + '/' + file)
          pp 11111111
        end
      }
      flash[:success] = "Successfully updated"
    else
      flash[:error] = "Directory does not exist"
    end
    redirect_to root_path
  end
end
