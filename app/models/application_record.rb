class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :soft_deleted, -> { unscope(where: :deleted).where(deleted: true) }

  default_scope { where(deleted: false) }
end
