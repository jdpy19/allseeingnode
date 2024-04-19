class BlocksController < ApplicationController
  def index
    @blocks = Block.all.order(height: :desc).limit(5)
  end
end
