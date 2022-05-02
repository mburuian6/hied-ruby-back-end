HALPresenter.base_href = 'http://localhost:8080/'
class UserSerializer
  extend HALPresenter

  attribute :email
  attribute :username
  attribute :created_at

  link :self do
    "/username/profile"
  end

end


