class FilesWatcherService

  CREATABLE_ATTRIBUTES = %i(name absolute_path)
  UPDATABLE_ATTRIBUTES = %i(size updating_time owner group permissions).freeze

  def initialize
    @tracked_direcrories = APP_CONFIG['tracked_directories']
  end

  def update_files
    @processed_data_sets = []
    @tracked_direcrories.each do |path|
      next unless Dir.exist? path
      Dir.glob(File.join(path, '**', '*')).each do |file|
        next unless File.file? file
        update_tracked_file(initialize_data_set(file))
      end
    end

    @data_sets_from_database = DataSet.all
    DataSet.where(id: @data_sets_from_database - @processed_data_sets).delete_all
  end

  private

  def update_tracked_file(attributes)
    data_set = DataSet.find_by(attributes.slice(*CREATABLE_ATTRIBUTES))
    if data_set.nil?
      data_set = DataSet.new(attributes)
      data_set.save!
    else
      data_set.update_attributes(attributes.slice(*UPDATABLE_ATTRIBUTES))
    end
    @processed_data_sets.push data_set
  end

  def initialize_data_set(file)
    data_set = {}

    data_set.tap do |attributes|
      attributes[:name] = File.basename file
      attributes[:size] = File.size file
      attributes[:absolute_path] = File.dirname file
      attributes[:updating_time] = File.mtime(file).to_datetime
      attributes[:owner] = Etc.getpwuid(File.stat(file).uid).name
      attributes[:group] = Etc.getgrgid(File.stat(file).gid).name
      attributes[:permissions] = File.stat(file).mode.to_s(8).to_i % 1000
    end

  end
end
