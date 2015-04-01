class SiteController < ApplicationController
  def ping
    logger.debug "here"
    render text: "PONG\n"
  end
end