class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :root

  def root
  end

end
