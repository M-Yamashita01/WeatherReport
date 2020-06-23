# frozen_string_literal: true

json.set! :micropost do
  json.extract! @micropost, :content, :created_at
end
