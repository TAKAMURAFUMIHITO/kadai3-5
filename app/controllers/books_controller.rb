class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice] = "You have created book successfully."
    else
      @create = Book.new
      @books = Book.all
      @user = User.find(current_user.id)
      render :index
    end
  end

  def index
    @book = Book.new
    @create = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end

  def show
    @create = Book.new
    @book = Book.find(params[:id])
    @books = Book.all
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user = current_user
      render :edit
    else
      redirect_to user_session_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path
      flash[:notice] = "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end