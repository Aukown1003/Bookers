class BooksController < ApplicationController
  def index
    # book.new定義しないとerr。要確認
    @book = Book.new
    @books = Book.all.order(id: :asc)
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    if @book.save
     flash[:notice] = "Posted successfully"
     redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    # book =Book.find~以降全てbookで記述時も問題なく動いていた、なぜ？
    @book = Book.find(params[:id])
    if @book.update(book_params)
     flash[:notice] = "Update successfully"
     redirect_to book_path(@book.id)
    else
      render :edit
    end
  end


  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Destroy successfully"
    redirect_to '/books'
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
