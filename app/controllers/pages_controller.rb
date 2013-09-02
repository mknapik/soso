class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def root
  end

  def show
    @page = Page.where(slug: params[:slug]).first
    authenticate_user! if @page.nil? or not @page.public
    redirect_to root_path, alert: 'No such page!' if @page.nil?
    #access_denied! :cannot_view_page if cannot? :view, @page
  end
end
