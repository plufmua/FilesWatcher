namespace :files_watcher do
  task update_info: :environment do
    UpdateFilesWorker.perform_async
  end
end
