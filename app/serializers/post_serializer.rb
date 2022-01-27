HALPresenter.base_href = 'http://localhost:8080/'
class PostSerializer
  extend HALPresenter

  attribute :title


  link :self do
    "/posts/#{resource.id}"
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

