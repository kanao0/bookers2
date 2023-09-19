class BooksController < ApplicationController
  
  def index
    # 新規投稿のデータを入れるための箱を作る名前は@book
    @book = Book.new
    # ブックの情報持ってきて
    @books = Book.all  
  end

  def create
    # 新規投稿フォームで入力されたデータが@bookに入る
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end
  
  
  def show
    # Bookモデルのデータ探すデータの箱は@bookって名前にしたよ
    @book = Book.find(params[:id])  
  end
   
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to book_path(book.id)  
  end 
  
  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    # 探してきたデータ（レコード）を削除
    book.destroy  
    redirect_to books_path  # 投稿一覧画面へリダイレクト    
  end
   
    private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end