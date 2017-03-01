namespace :files_watcher do
  task update_info: :environment do
    UpdateFilesJob.perform_now
  end
end
