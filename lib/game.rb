require_relative 'card_deck'
require_relative 'player'

class Game
  attr_reader :card_deck
  attr_accessor :players, :current_player, :started, :cpu_arr

  def initialize
    @started = false
    @card_deck = CardDeck.new
    @players = []
    @current_player = players[0]
  end

  def create_cpu(cpu_number)
    cpu_number.times do |index| 
      players << CPU.new("CPU#{index + 1}")
    end
  end

  def add_player(player)
    players << player
  end

  def empty?
    players.empty?
  end

  def find_current_player(player_name)
    players.each {|player| return player if player.name == player_name}
  end

  def deal
    deal_count.times do
      players.each {|player| player.add_cards_to_hand(card_deck.deal)}
    end
  end

  def deal_count
    players.count > 2 ? 5:7
  end

  def start 
    self.started = true
    deal_count
    deal
  end
end

class CPU < Player
  
end