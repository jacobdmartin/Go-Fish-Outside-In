require_relative 'game'

class CPU < Player
  attr_reader :players, :name

  def initialize(players = nil, name)
    @players = players
    @name = name
    @hand = []
    @completed_matches = []
  end
  
  def return_rank
    card = hand.sample
    rank = card.rank
    rank
  end

  def return_player
    asked_player = players.sample
    asked_player
  end
end