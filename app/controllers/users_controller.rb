class UsersController < ApplicationController
  def index
    
    # ユーザーの情報もってこい
    @users = User.all
    # 新規投稿のための箱
    @book = Book.new
  end
  
  def show
    @book = Book.new
    @books = Book.all
    # ユーザーの情報探してきて
    @user = User.find(params[:id])
  end
  
  def edit
    # ユーザーの情報探してきて
    @user = User.find(params[:id])
  end
  
  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user.id)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction )
  end
  

end
