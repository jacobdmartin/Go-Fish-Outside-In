require_relative 'card_deck'
require_relative 'player'
require_relative 'cpu'

class Game
  attr_reader :card_deck
  attr_accessor :players, :current_player, :started, :cpu_arr

  def initialize
    @started = false
    @card_deck = CardDeck.new
    @players = []
    @current_player = nil
  end

  def create_cpu(cpu_number)
    cpu_number.times do |index| 
      players << CPU.new("CPU#{index + 1}")
    end
    start
    self.current_player = players[0]
  end

  def add_player(player)
    players << player
  end

  def empty?
    players.empty?
  end

  def find_current_player(player)
    players.each do |player| 
      return player if player.name == player.name
    end
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
    if players.count > 1
      self.started = true
      card_deck.shuffle
      deal_count
      deal
    end
  end

  def take_turn(asking_player, asked_player, rank)
    asked_player.has_rank?(rank) ? player_takes_card(asking_player, asked_player, rank) : player_go_fish(asking_player, asked_player, rank)
  end

  def player_takes_card(asking_player, asked_player, rank)

  end

  def player_go_fish(asking_player, asked_player, rank)

  end

  def player_fished_asked_rank(rank)

  end

  def go_fish(player)

  end
end