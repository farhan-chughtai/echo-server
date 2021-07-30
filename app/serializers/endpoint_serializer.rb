class EndpointSerializer < ActiveModel::Serializer
  attributes :id, :verb, :path, :response
end
