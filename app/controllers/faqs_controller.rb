class FaqsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @faqs = if user_signed_in?
              Faq.where(published: true).select { |faq| can? :view, faq }
            else
              Faq.where(public: true, published: true)
            end
    puts @faqs.inspect
  end

  def show
    @faq = Faq.find(params[:id])
    redirect_to faqs_path, notice: 'Faq was successfully created.' if cannot? :view, @faq
  end
end
