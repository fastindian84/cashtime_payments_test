class CreateAppRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :app_requests do |t|
      t.string :title
      t.string :description
      t.string :user_name
      t.string :image_url
      t.decimal :amount
      t.string :app_id
      t.string :public_key
      t.string :order_uid
      t.string :user_uid
      t.string :status
      t.string :response

      t.timestamps
    end
  end
end
