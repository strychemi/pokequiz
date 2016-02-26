module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(query_hash)
      results = self.where("")
      if query_hash
        query_hash.each do |col, value|
          results = results.where("#{col} LIKE ?", "%#{value}%") if value.present?
        end
      end
      results
    end
  end
end