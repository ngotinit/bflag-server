module API
  module V1
    class UserAPI < Grape::API
      desc 'API for user'
      resources :user do
        desc "Get user's information", {
          headers: {
            "Token" => {
              description: "Validates your identity",
              required: true
            }
          }
        }
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

          raise ActiveRecord::RecordNotFound 'Email not found' if user.nil?

          unless user.valid_password?(declared_params[:password])
            error!('Incorrect password', 401)
          end

          user.generate_token
          present({ status: 'ok', token: user.auth_token }, 200)
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
          present({ status: 'ok' }, 200)
        end

        desc "Edit user's profile", {
          headers: {
            "Token" => {
              description: "Validates your identity",
              required: true
            }
          }
        }
        params do
          optional :first_name, type: String
          optional :last_name, type: String
          optional :username, type: String
        end
        put 'edit' do
          authenticate_token!
          current_user.update!(declared(params, include_missing: false))
          present current_user, with: Entities::UserEntity
        end

        desc "Log user out", {
          headers: {
            "Token" => {
              description: "Validates your identity",
              required: true
            }
          }
        }
        delete 'sign_out' do
          authenticate_token!
          current_user.destroy_token
          present({ status: 'ok' }, 200)
        end
      end
    end
  end
end
