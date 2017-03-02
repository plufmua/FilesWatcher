class FilesWatcherService
  def initialize
    @tracked_direcrories = ENV['tracked_directories'].scan(/[\/.*\.[\w:\s]+]+/)
  end

  def update_files
    @data_sets = DataSet.all.to_a

    @tracked_direcrories.each do |path|
      next unless Dir.exist? path
      Dir.glob(File.join(path, '**', '*')).each do |file|
        next unless File.file? file
        update_tracked_files set_data_set (file)
        end
    end
    DataSet.where(id: @data_sets).delete_all
  end

  private

  def update_tracked_files(data_set)
    if DataSet.exists?(name: data_set.name, absolute_path: data_set.absolute_path)
      DataSet.find_by(name: data_set.name, absolute_path: data_set.absolute_path)
          .update_attributes(size: data_set.size,
                             updating_time: data_set.updating_time,
                             owner: data_set.owner,
                             group: data_set.group,
                             permissions: data_set.permissions)

      @data_sets.delete_if { |dataset| dataset.name == data_set.name && dataset.absolute_path == data_set.absolute_path }

    else
      data_set.save!
    end

  end

  def set_data_set(file)
    data_set = DataSet.new
    data_set.name = File.basename file
    data_set.size = File.size file
    data_set.absolute_path = File.dirname file
    data_set.updating_time = File.mtime(file).to_datetime
    data_set.owner = Etc.getpwuid(File.stat(file).uid).name
    data_set.group = Etc.getgrgid(File.stat(file).gid).name
    data_set.permissions = File.stat(file).mode.to_s(8).to_i % 1000

    data_set
  end
end
