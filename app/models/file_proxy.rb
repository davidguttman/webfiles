class FileProxy
  def initialize(path="/")
    @base_path = PATH_CONFIG[:base_path]
  
    @target_path = File.expand_path(path)
    @page_title = "#{@target_path}"
    @full_path = File.expand_path("#{@base_path}#{@target_path}")
    @path_name = File.basename(@full_path)
  end
  
  
end