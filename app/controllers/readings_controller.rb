class ReadingsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  # def create
  #   @reading = current_user.readings.build(reading_params)
  #   if @reading.save
  #     flash[:success] = "Reading created!"
  #     redirect_to root_url
  #   else
  #     @feed_items = []
  #     render 'static_pages/home'
  #   end
  # end

  def create
    @book = Book.find_by(title: params[:book][:title])

    unless @book
      # créer le book, puis l'offer
      @book = Book.new(params_book)
      @book.save
      # @book.sync_with_amazon
    end

    @reading      = @book.readings.new
    if current_user.offers.map { |offer| offer.book }.include? @book
      flash.now[:alert] = "You alreay read this book"
      render :new
    else
      @reading = current_user.readings.build(reading_params)
      # @reading.user = current_user
      @reading.book = @book
      if @reading.save
        flash[:success] = "Reading created!"
        redirect_to root_url
      else
        @feed_items = []
        render 'static_pages/home'
      end
    end
  end

  def destroy
    @reading.destroy
    flash[:success] = "Reading deleted"
    redirect_to request.referrer || root_url
  end

  private

    def reading_params
      params.require(:reading).permit(:comment, :book_id, :grade)
    end

    def params_book
      params.require(:book).permit(:title, :description, :category, :author)
    end

     def correct_user
      @reading = current_user.readings.find_by(id: params[:id])
      redirect_to root_url if @reading.nil?
    end
end



