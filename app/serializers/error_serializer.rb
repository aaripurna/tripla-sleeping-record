class ErrorSerializer
  def initialize(errors, status: :status)
    @errors = errors
    @status = status
  end

  def as_json
    {
      errors: @errors.map do |e|
        { source: { pointer: e.attribute }, detail: e.message }
      end
    }
  end

  alias to_h as_json
end
