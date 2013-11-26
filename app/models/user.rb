class User < ActiveRecord::Base

  def self.create_with_omniauth(auth)
    create! do |user|
      @user = user
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth['info']['name'] || ""
        user.email = auth['info']['email'] || ""
        user.permalink =  (auth['info']['name'] || "").downcase.tr(" ", "_")
      end
    end
  end

end
