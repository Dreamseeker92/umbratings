class AddIndexOnAuthorIpToPosts < ActiveRecord::Migration[5.2]
  def change
    add_index(:posts, :author_ip, using: 'hash')
  end
end
