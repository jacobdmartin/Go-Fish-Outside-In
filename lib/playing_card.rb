require_relative '../lib/card_deck'
require_relative '../lib/game'

class PlayingCard
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    return 11 if rank == "Jack"
    return 12 if rank == "Queen"
    return 13 if rank == "King"
    return 14 if rank == "Ace"
    rank.to_i
  end
end