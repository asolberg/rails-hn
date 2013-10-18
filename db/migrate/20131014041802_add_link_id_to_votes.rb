class AddLinkIdToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :link_id, :integer
    add_index :votes, :link_id
  end
  def self.down
    drop_column :votes, :link_id
  end
end
