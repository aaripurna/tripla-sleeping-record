class ApplicationSerializer < JSONAPI::Serializable::Resource
  Renderer = JSONAPI::Serializable::Renderer.new

  def as_json
    self.as_jsonapi
  end

  alias to_h as_json
end
