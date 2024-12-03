class PaginationContract < Dry::Validation::Contract
  params do
    required(:page).filled(:integer)
    required(:count).filled(:integer)
    required(:limit).filled(:integer)
    required(:next).maybe(:integer)
    required(:prev).maybe(:integer)
  end
end

class PaginationLinkContract < Dry::Validation::Contract
  params do
    required(:self).filled(:string)
    required(:first).filled(:string)
    required(:last).filled(:string)
    required(:next).maybe(:string)
    required(:prev).maybe(:string)
  end
end
