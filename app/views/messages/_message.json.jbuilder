json.extract! message, :id, :ind, :message, :created_at, :updated_at
json.url message_url(message, format: :json)
