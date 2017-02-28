class UpdateFilesJob < ApplicationJob
  include DataSetsHelper
  queue_as :default


  def perform(*args)

    update_tracked_files
  end
end
