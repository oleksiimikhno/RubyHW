# frozen_string_literal: true

# Handler check login/password user
module AuthenticationUser
  class << self
    def verify(json)
      @user = json['login']
      @password = json['password']

      if @user.empty? || @password.empty?
        { error: true, message: 'Please enter your username or password' }
      else
        exist_user? ? { error: false } : { error: true, message: 'Input current username or password' }
      end
    end

    private

    def exist_user?
      @user == 'admin' && @password == 'admin'
    end
  end
end
