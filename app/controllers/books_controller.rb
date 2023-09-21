class BooksController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update]
  def index
    @book = Book.new
    # ログインしてるユーザーの情報これはUserinfoで使う
    @user = current_user
    @books = Book.all
  end

  def create
    # 新規投稿フォームで入力されたデータが@bookに入るデータ入れてあげる
    # title,bodyのデータだけ
    @book = Book.new(book_params)
    # ユーザーと紐付けしてるから誰が投稿したかの情報も一緒に入れてあげる
    @book.user_id = current_user.id
    # saveできると投稿したものに対してidがふられる
    # 保存したデータのidの詳細ページにいく
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)  
    else
      # ログインしてるユーザーの情報これはUserinfoで使う
      @user = current_user
      @books = Book.all
      render :index
    end
  end


  def show
    # 本の情報をURLから取得
    @book = Book.find(params[:id])
    # 本を投稿したユーザーの情報＊これはUserinfoで使う
    @user = @book.user
    # @bookふたつになるから@book_new部分テンプレは大丈夫
    @book_new = Book.new
  end

  def edit
     @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    # 今のURLの中のIDの情報持ってきてね
    @book = Book.find(params[:id])
    # 探してきたデータ（レコード）を削除
    @book.destroy
    # 投稿一覧画面へリダイレクト
    redirect_to books_path        
  end

    private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end 
  end

end