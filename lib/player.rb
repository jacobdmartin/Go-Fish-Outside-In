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

  def add_players_cards_to_hand(cards)
    cards.each {|card| hand << card}
  end

  def unique_ranks
    @hand.map(&:rank).uniq
  end

  def has_rank?(rank)
    hand.map(&:rank).include?(rank)
  end

  def count_matches
    number_of_ranks = Hash.new(0)
    hand.each {|card| number_of_ranks[card.rank] += 1}
    number_of_ranks.each {|rank, cards| add_book(rank) if cards == 4}
  end

  # private

  def players_rank_number
    number_of_ranks = Hash.new(0)
    hand.each {|card| number_of_ranks[card.rank] += 1}
    number_of_ranks
  end

  def add_book(rank)
    remove_cards_from_hand(rank)
    completed_matches.push(rank)
  end

  def remove_cards_from_hand(asked_rank)
    rank_arr = hand.select {|card| card.rank == asked_rank}
    hand.delete_if {|card| card.rank == asked_rank}
    rank_arr
  end
end