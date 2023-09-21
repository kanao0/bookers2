class ApplicationController < ActionController::Base
# ログインしてない人がアクセスするとログイン画面に戻る＊top,about画面は除く
 before_action :authenticate_user!, except: [:top,:about ]

# nameをデータとして保存できるように許可
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
  
  protected

# [:name]
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
