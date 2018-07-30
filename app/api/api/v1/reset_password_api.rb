module API
  module V1
    class ResetPasswordAPI < Grape::API
      resources :reset_password do
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

        params do
          requires :email, type: String
          requires :reset_code, type: String
          optional :password, type: String
        end
        post '/auth' do
          declared_params = declared(params)
          user = User.find_by(email: declared_params[:email])

          unless user
            return present({ error: 'Email not found' }, 404)
          end

          if user.reset_expired?
            return present({ error: 'Password reset has expired' }, 422)
          end

          if user.valid_reset_code?(declared_params[:reset_code])
            present({ status: 'ok' }, 200)

            if declared_params[:password].present?
              user.update!(password: declared_params[:password])
            end
          else
            present({ error: 'Invalid reset password code' }, )
          end
        end
      end
    end
  end
end
