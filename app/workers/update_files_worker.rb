class UpdateFilesWorker
  include Sidekiq::Worker

  def perform(*_args)
    FilesWatcherService.new.update_files
  end
end
