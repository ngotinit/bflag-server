module API
  module V1
    class ResetPasswordAPI < Grape::API
    # /api/v1/reset_password/
    params do
      requires :email, type: String
    end
    post do
      user = User.find_by(email: declared(params)[:email])
      if user
        user.create_reset_code
        user.send_password_reset_mail
        present({ status: 'ok' }, 200)
      else
        present({ error: 'Email not found' }, 404)
      end
    end

    # /api/v1/reset_password/auth
    params do
      requires :reset_code, type: String
    end
    post 'auth/?email=:email' do
      declared_params = declared(params)
      user = User.find_by(email: declared_params[:email])

      unless user
        present({ error: 'Email not found' }, 404)
      end

      if user.reset_expired?
        present({ error: 'Password reset has expired' }, 422)
      end

      if user.valid_reset_code?(declared_params[:reset_code])
        present({ status: 'ok' }, 200)
      else
        present({ error: 'Invalid reset password code' }, )
      end
    end

    params do
      requires :password, type: String
    end
    put 'edit/?email=:email' do
      declared_params = declared(params)
      user = User.find_by(email: declared_params[:email])
      user.update!(password: declared_params[:password])
    end
  end
end
