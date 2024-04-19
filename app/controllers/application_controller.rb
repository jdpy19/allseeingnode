class ApplicationController < ActionController::Base

  def respond_to_format(path, notice)
    respond_to do |format|
      format.html { redirect_to path, notice }
      format.turbo_stream { flash.now[:notice] = notice }
    end
  end

end
