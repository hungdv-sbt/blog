class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  DEFAULT_ITEMS_EACH_PAGE = 10
end
