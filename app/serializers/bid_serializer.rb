HALPresenter.base_href = 'http://localhost:8080/'
class BidSerializer
  extend HALPresenter

  attribute :pay
  attribute :notes
  attribute :username
  attribute :accepted
  attribute :created_at
  attribute :updated_at
  attribute :hash_id
  attribute :post_id do
    resource.post.hash_id
  end

  link :self do
    "/bids/#{resource.hash_id}"
  end

  collection of: 'bids' do
    attribute(:count) { resources.count }
    link :self do
      format "/bids%s", (options[:page] && "?page=#{options[:page]}")
    end
    link :next do
      "/bids?page=#{options[:next]}" if options[:next]
    end
  end

end

