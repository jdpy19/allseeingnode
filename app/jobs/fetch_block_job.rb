class FetchBlockJob < ApplicationJob
  queue_as :default

  def perform(*args)
    height = args[0]
    begin
      stdout, status = Open3.capture2("./get_block.sh #{height}")
      unless stdout.empty? || stdout.nil? || stdout.include?('error code: -8')
        stats = JSON.parse(stdout)
        block = Block.find_by_height(stats['height'])
        if block.nil?
          block = Block.create({
            block_hash: stats['blockhash'],
            height: stats['height'],
            time: stats['time'],
            total_fee: stats['totalfee'],
            subsidy: stats['subsidy']
          })
        end
        FetchBlockJob.perform_later(height + 1)
      end
    rescue => e
      Rails.logger.error "Error fetching block at height: #{height}"
      Rails.logger.error e.message
      FetchBlockJob.set(wait: 1.minute).perform_later(height)
    end
  end
end
