class BooksController < ApplicationController
  # def new
  # end
  
  def index
    # 新規投稿のデータを入れるための箱を作る名前は@book
    @book = Book.new
  end

  def create
    # 新規投稿フォームで入力されたデータが@bookに入る
    @book = Book.new(book_params)
    # 投稿したユーザーが誰か
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end
  
  
  def show
    # Bookモデルのデータみつけてきて～データの箱は@bookって名前にしたよ
    @book = Book.find(params[:id])    
  end
   
    private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end


# def create
#     # データを保存するための箱を作る名前は@book
#     @book = Book.new(book_params)

#     if @book.save

#       redirect_to book_path(@book.id)
#       flash[:notice] = "You have created book successfully."    
#     else
#       @books = Book.all
#       render :index
  #   end
  # end