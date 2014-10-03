class User < ActiveRecord::Base
	# emailを小文字に変換する（一意性を保証する為）　
	before_save { self.email = email.downcase }
	# 存在性の入力チェック　→　presence
	# 長さのチェック       →　length
	# validates (:name, presence: true) とも記述できる
	validates :name,  presence: true, length: { maximum: 50 }


	# 	/			正規表現の開始を示す
	# \A			文字列の先頭
	# [\w+\-.]+		英数字、アンダースコア (_)、プラス (+)、ハイフン (-)、ドット (.) のいずれかを少なくとも1文字以上繰り返す
	# @				アットマーク
	# [a-z\d\-.]+	英小文字、数字、ハイフン、ドットのいずれかを少なくとも1文字以上繰り返す
	# \.			ドット
	# [a-z]+		英小文字を少なくとも1文字以上繰り返す
	# \z			文字列の末尾
	# /				正規表現の終わりを示す
	# i				大文字小文字を無視するオプション

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
				uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, length: { minimum: 6 }
end
