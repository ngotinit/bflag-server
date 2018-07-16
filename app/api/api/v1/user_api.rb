module API
  module V1
    class UserAPI < Grape::API
      resources :user do
        get do
          authenticate_token!
          present current_user, with: Entities::UserEntity
        end

        params do
          requires :email, type: String
          requires :password, type: String
        end
        post 'sign_in' do
          declared_params = declared(params)
          user = User.find_by(email: declared_params[:email])

          if user.nil?
            raise ActiveRecord::RecordNotFound 'Email not found'
          end

          unless user.valid_password?(declared_params[:password])
            error!({ error_message: 'Incorrect password' }, :unauthorized)
          end

          user.generate_token
          present({ status: 'ok', token: user.auth_token }, :success)
        end

        params do
          requires :first_name, type: String
          requires :last_name, type: String
          requires :username, type: String
          requires :email, type: String
          requires :password, type: String
        end
        post 'sign_up' do
          User.create!(declared(params))
        end

        params do
          optional :first_name, type: String
          optional :last_name, type: String
          optional :username, type: String
        end
        put 'edit' do
          current_user.update!(declared(params, include_missing: false))
          present current_user, with: Entities::UserEntity
        end

        delete 'sign_out' do
          authenticate_token
          current_user.destroy_token
          present({ status: "ok" }, 200)
        end
      end
    end
  end
end
