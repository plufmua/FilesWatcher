class UpdateFilesJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    FilesWatcherService.new
  end
end
