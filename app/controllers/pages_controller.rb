class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :root

  def root
  end

  def show
    @page = Page.where(slug: params[:slug]).first
    raise ActiveRecord::RecordNotFound, 'Page not found' if @page.nil?
  end
end
