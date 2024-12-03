class ApiAttributeError < Dry::Validation::Contract
  params do
    required(:source).hash do
      required(:pointer).filled(:string)
    end

    required(:detail).filled(:string)
  end
end

class ApiGenericError < Dry::Validation::Contract
  params do
    required(:errors).array(ApiAttributeError.schema)
  end
end
