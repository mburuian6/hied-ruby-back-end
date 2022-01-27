HALPresenter.base_href = 'http://localhost:8080/'
class PostSerializer
  extend HALPresenter

  attribute :title


  link :self do
    "/posts/#{resource.id}"
  end

end

