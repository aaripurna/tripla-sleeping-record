class ApplicationSerializer < JSONAPI::Serializable::Resource
  def as_json
    self.as_jsonapi
  end

  alias to_h as_json
end
