class ApplicationController < ActionController::Base
  protect_from_forgery

private

  def set_dir
    @base_path = PATH_CONFIG["base_path"]
  
    @target_path = File.expand_path("#{params[:path] || "/"}")
    @page_title = "#{@target_path}"
    @full_path = File.expand_path("#{@base_path}#{@target_path}")
    @path_name = File.basename(@full_path)
  end
  

  def render_json(data)
    json = data.to_json
    callback, variable = params[:callback], params[:variable]

    if callback && variable
      response = "var #{variable} = #{json};\n#{callback}(#{variable});"
    elsif variable
      response = "var #{variable} = #{json};"  
    elsif callback
      response = "#{callback}(#{json});"  
    else
      response = json
    end

    render :json => response
  end

end
