json.set! :micropost do
  json.array! @micropost do |micropost|
    json.extract! micropost, :content
  end
end
