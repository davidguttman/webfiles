class FilesController < ApplicationController

  before_filter :set_dir

  def index
    @info = get_file_info(@full_path)
    
    if @info[:directory?]
      @files = get_files(@full_path)
    else
      send_file(@full_path)
      return
    end
    
    respond_to do |format|
      format.html
      format.json { render_json @files }
    end
  end

private

  def get_files(full_path)
    files = []
    Dir.foreach(full_path) do |n|
      fn = full_path + "/" + n
      file_info = get_file_info(fn)
      files << file_info if file_info
    end
    files
  end

  def get_file_info(full_path)
    if File.exists?(full_path)
      name = File.basename full_path
      is_directory = File.directory?(full_path)
      mtime = File.mtime(full_path)
      extname = File.extname(full_path).downcase
      target_path = full_path[PATH_CONFIG["base_path"].size-1..-1] 
      target_path = "/" if target_path == ""

      basename = File.basename full_path, ".#{extname}"
      
      info = { :name => name, 
        :directory? => is_directory, 
        :mtime => mtime, 
        :extname => extname, 
        :target_path => target_path, 
        :basename => basename }
        
    end
  end

end
