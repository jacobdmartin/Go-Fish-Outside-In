class Player
  attr_accessor :name, :hand, :completed_matches

  def initialize(name)
    @name = name
    @hand = []
    @completed_matches = []
  end

  def add_cards_to_hand(*cards)
    cards.each {|card| hand << card}
  end

  def unique_ranks
    @hand.map(&:rank).uniq
  end

  def has_rank?(rank)
    hand.map(&:rank).include?(rank)
  end

  def remove_cards_from_hand(rank)

  end

  def count_matches(new_card)

  end
end