class UsersController < ApplicationController
  def index
    # ログインしてるユーザーの情報＊これはUserinfoで使う
    @user = current_user
    # ユーザーの情報もってきてUsersで使う
    @users = User.all
    # 新規投稿のための箱
    @book = Book.new
  end
  
  def show
    @book = Book.new
    # 特定のユーザーの情報URLから参照して探してきて
    @user = User.find(params[:id])
    # ↑のユーザー情報からbooks情報もらう@booksで使えるようにする
    @books = @user.books
  end
  
  def edit
    # ユーザーの情報探してきて
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
    　render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction )
  end
  

end
