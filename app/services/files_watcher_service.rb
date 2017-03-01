class FilesWatcherService

  def initialize
    update_tracked_files
  end

  private

  def update_tracked_files
    @data_sets = DataSet.all.to_a
    splited = ENV["tracked_directories"].scan(/[\/.*\.[\w:\s]+]+/)
    splited.each do |path|
      if Dir.exist? path
        Dir.glob(File.join(path, '**', '*')).each do |file|
          next unless File.file?(file)
          data_set = DataSet.new
          data_set.name = file.split('/')[-1]
          data_set.size = File.size(file)
          data_set.absolute_path = file[0..file.rindex('/')]
          data_set.updating_time = File.mtime(file).to_datetime
          data_set.owner = Etc.getpwuid(File.stat(file).uid).name
          data_set.group = Etc.getgrgid(File.stat(file).gid).name
          data_set.permissions = File.stat(file).mode.to_s(8).to_i % 1000
          if DataSet.exists?(name: data_set.name, absolute_path: data_set.absolute_path)
            DataSet.find_by(name: data_set.name, absolute_path: data_set.absolute_path)
                .update_attributes(size: data_set.size, updating_time: data_set.updating_time, owner: data_set.owner, group: data_set.group, permissions: data_set.permissions)
            @data_sets.delete_if { |dataset| dataset.name == data_set.name && dataset.absolute_path == data_set.absolute_path }
          else
            data_set.save!
          end
        end
      else
        next
      end
    end
    @data_sets.each(&:delete)
  end
end