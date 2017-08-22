# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date
#  end_date   :date
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord
  validates :status, :cat_id, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }

  def overlapping_requests
    CatRentalRequest
                    .where(cat_id: self.cat_id)
                    .where_not(id: self.id)
  end

  belongs_to :cat,
    class_name: :Cat,
    primary_key: :id,
    foreign_key: :cat_id
end
