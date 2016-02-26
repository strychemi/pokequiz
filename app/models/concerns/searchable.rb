module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(query_hash)
      results = self.where("")
      if query_hash
        query_hash.each do |column, term|
          results = results.where("#{column} LIKE ?", "%#{term}%") if term.present?
        end
      end
      results
    end
  end
end