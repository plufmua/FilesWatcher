class UpdateFilesWorker
  include Sidekiq::Worker

  def perform(*_args)
    FilesWatcherService.new
  end
end
