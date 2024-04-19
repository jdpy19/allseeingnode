class Block < ApplicationRecord
  after_commit :send_block_height, on: [:create]
  broadcasts_to ->(block) { ["blocks"] }, inserts_by: :prepend

  def send_block_height
    broadcast_update_to('blocks', target: 'block_height', html: height )
  end
end
