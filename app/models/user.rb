class User < ApplicationRecord
  validates :name, presence: true,uniqueness: true
  validates :name, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# profile_imageという名前でActiveStorageで
# プロフィール画像を保存できるように設定
  has_one_attached :profile_image
  has_many :books, dependent: :destroy

  # 画像が設定されない場合はdefault_image.jpgをデフォルト画像として格納
  # 画像あれば(width, height)指定して表示??
  # get_profile_image画像を表示する時に使う
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end