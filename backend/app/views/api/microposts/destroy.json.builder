# frozen_string_literal: true

json.set! :micropost do
  json.extract! @post, :status
end
