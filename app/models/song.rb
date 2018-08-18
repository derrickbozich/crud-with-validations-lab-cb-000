class Song < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true, if: :released_in_a_different_year?
  validates :released, inclusion: { in: [ true, false ] }
  validates :release_year, presence: true, if: :released_status?, inclusion: { in: 1900..Date.today.year }
  validates :artist_name, presence: true
  validate :artist_name_type
  validate :genre_name_type
  validate :title_name_type

  # validates :card_number, presence: true, if: :paid_with_card?
  #
  # def paid_with_card?
  #   payment_type == "card"
  # end

  def genre_name_type
    self.genre.class == String
  end

  def title_name_type
    self.title.class == String
  end

  def artist_name_type
    self.artist_name.class == String
  end

  def released_status?
    self.released
  end

  def released_in_a_different_year?
    Song.all.none? do |s|
      self.release_year != s.release_year && self.artist_name != s.artist_name
    end
  end




end
