class FilesWatcherService
  def initialize
    @tracked_direcrories = APP_CONFIG['tracked_directories']
    @data_sets = []
  end

  def update_files
    @tracked_direcrories.each do |path|
      next unless Dir.exist? path
      Dir.glob(File.join(path, '**', '*')).each do |file|
        next unless File.file? file
        update_tracked_file(initialize_data_set(file))
      end
    end

    @data_sets_from_database = DataSet.all
    pp @delete_from_database = @data_sets_from_database - (@data_sets & @data_sets_from_database)

    DataSet.where(id: @delete_from_database).delete_all
  end

  private

  def update_tracked_file(data_set)
    # DataSet.find_or_create_by(data_set)
    @data_sets.push DataSet.find_or_create_by(data_set)
  end

  def initialize_data_set(file)
    data_set = Hash.new
    data_set[:name] = File.basename file
    data_set[:size] = File.size file
    data_set[:absolute_path] = File.dirname file
    data_set[:updating_time] = File.mtime(file).to_datetime
    data_set[:owner] = Etc.getpwuid(File.stat(file).uid).name
    data_set[:group] = Etc.getgrgid(File.stat(file).gid).name
    data_set[:permissions] = File.stat(file).mode.to_s(8).to_i % 1000

    data_set
  end
end
