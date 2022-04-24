HALPresenter.base_href = 'http://localhost:8080/'
class PostSerializer
  extend HALPresenter

  attribute :title
  attribute :pay
  attribute :closed
  attribute :description
  attribute :start
  attribute :username
  attribute :hash_id
  attribute :created_at
  attribute :updated_at

  link :self do
    "/post_link?marker=#{resource.hash_id}"
  end

  collection of: 'posts' do
    attribute(:count) { resources.count }
    link :self do
      format "/posts%s", (options[:page] && "?page=#{options[:page]}")
    end
    link :next do
      "/posts?page=#{options[:next]}" if options[:next]
    end
  end

end

