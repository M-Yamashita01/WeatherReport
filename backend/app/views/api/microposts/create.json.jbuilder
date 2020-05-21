json.set! :micropost do
  json.extract! @micropost, :content, :created_at
end
