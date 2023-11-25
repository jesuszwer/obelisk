class CommentsChangeSenderId < ActiveRecord::Migration[7.1]
  def change
    change_column :comments, :sender_id, :string
  end
end
