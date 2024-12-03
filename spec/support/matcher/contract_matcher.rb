require 'rspec/expectations'

RSpec::Matchers.define :match_contract do |contract_klass|
  description { 'JSON schema match data contract' }
  failure_message { "error exists #{actual.errors.to_h}" }
  failure_message_when_negated { "no error exists in #{actual.errors.to_h}" }


  match do |response|
    contract = contract_klass.new
    data = JSON.parse(response.body) rescue {}
    @actual = contract.call(data)
    @actual.errors.none?
  end
end
