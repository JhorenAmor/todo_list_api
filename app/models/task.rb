class Task < ApplicationRecord
  include RankedModel

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  ranks :row_order

  def formatted_json
    {
      id: id,
      title: title,
      description: description,
      row_order: row_order_rank,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end
