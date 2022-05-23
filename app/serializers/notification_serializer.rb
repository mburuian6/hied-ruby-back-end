HALPresenter.base_href = 'http://localhost:8080/'
class NotificationSerializer
  extend HALPresenter

  attribute :notification_type
  attribute :username
  attribute :notification_references
  attribute :data
  attribute :created_at
  attribute :updated_at
  attribute :hash_id
  attribute :notification_opened

  link :self do
    "/notifications/#{resource.hash_id}"
  end

  collection of: 'notifications' do
    attribute(:count) { resources.count }
    link :self do
      format "/notifications%s", (options[:page] && "?page=#{options[:page]}")
    end
    link :next do
      "/notifications?page=#{options[:next]}" if options[:next]
    end
  end

end


