json.set! :micropost do
  json.array! @micropost do |micropost|
    json.extract! micropost, :id, :user_id, :name, :content, :created_at
  end
end
