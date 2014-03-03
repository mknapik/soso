class FaqsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @faqs = if user_signed_in?
              Faq.where(published: true).select { |faq| can? :read, faq }
            else
              Faq.where(public: true, published: true)
            end
  end

  def show
    @faq = Faq.find(params[:id])
    access_denied! 'cannot.view.faq', faqs_path if cannot? :read, @faq
  end

  def sort
    access_denied! 'cannot.edit.faq' if cannot? :update, Faq
    faq_ids = params.permit(:faq => [])[:faq]
    faqs = Faq.find(faq_ids)

    faqs = faqs.index_by(&:id)
    faq_ids.each.with_index do |faq_id, index|
      faqs[faq_id.to_i].update(position: index+1)
    end
    render nothing: true
  end
end
