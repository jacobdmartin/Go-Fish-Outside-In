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
end