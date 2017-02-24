class DataSetsController < ApplicationController
  require 'find'

  def index
    @data_sets = DataSet.page(params[:page])
  end

  def show
    @data_set = DataSet.find(params[:id])
  end
  # method to update files in database
  def update_files
    paths = [ "/home/zharko/Untitled Folder", "/home/zharko/Untitled Folder" ]
    paths.each do |path|
      if Dir.exist? path
        Dir.glob(File.join(path, '**', '*')).each { |file|
          if File.file?(file)
            data_set = DataSet.new
            data_set.name = file.split('/')[-1]
            data_set.size = File.size(file)
            data_set.absolute_path = file
            data_set.updating_time = File.mtime file
            data_set.owner = File.stat(file).uid
            data_set.group = File.stat(file).gid
            data_set.permissions = File.stat(file).mode.to_s(8).to_i%1000
            data_set.save!
          end
        }
      else
        next
      end
    end
    redirect_to root_path
  end
end
