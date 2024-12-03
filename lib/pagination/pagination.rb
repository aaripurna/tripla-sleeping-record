
module Pagination
  class Pagination
    include Pagy::Backend

    def initialize(base_url, params = {})
      @base_url = base_url
      @params = params
    end

    def paginate(query, **kargs)
      pagination, records = pagy(query, **kargs)

      [ Response.new(pagination, @base_url, @params), records ]
    end
  end
end
