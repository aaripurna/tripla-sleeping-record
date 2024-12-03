module Pagination
  class PaginationLinks
    def initialize(pagination, base_url, params)
      @response = {
        "self" => base_url + "?page=#{pagination.page}&limit=#{pagination.limit}&#{parse_params(params)}",
        "first" => base_url + "?page=1&limit=#{pagination.limit}&#{parse_params(params)}",
        "prev" => pagination.prev.present? ?  base_url + "?page=#{pagination.prev}&limit=#{pagination.limit}&#{parse_params(params)}" : nil,
        "next" => pagination.next.present? ? base_url + "?page=#{pagination.next}&limit=#{pagination.limit}&#{parse_params(params)}" : nil,
        "last" => base_url + "?page=#{pagination.last}&limit=#{pagination.limit}&#{parse_params(params)}"
      }
    end

    def as_json
      @response
    end

    alias to_h as_json

    private

    def parse_params(params = {})
      params.map { |k, v| "#{k}=#{v}" }.join("&")
    end
  end

  class Response
    attr_reader :links, :details
    def initialize(pagination, base_url, params = {})
      @links = PaginationLinks.new(pagination, base_url, params)
      @details = { page: pagination.page, next: pagination.next, prev: pagination.prev, count: pagination.count, limit: pagination.limit }
    end
  end
end
