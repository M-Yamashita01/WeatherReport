json.set! :micropost do
  json.array! @micropost do |micropost|
    json.extract! micropost, :user_id, :name, :content, :created_at
  end
end
