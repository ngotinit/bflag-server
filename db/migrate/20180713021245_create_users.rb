class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :profile_image
      t.string :auth_token
      t.timestamps
    end
  end
end
