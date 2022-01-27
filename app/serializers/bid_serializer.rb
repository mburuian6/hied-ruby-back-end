HALPresenter.base_href = 'http://localhost:8080/'
class BidSerializer
  extend HALPresenter

  attribute :pay
  attribute :notes
  attribute :post_id
  attribute :owner
  attribute :created_at
  attribute :updated_at

  link :self do
    "/bids/#{resource.id}"
  end

end

