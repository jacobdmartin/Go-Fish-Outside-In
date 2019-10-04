require_relative 'card_deck'
require_relative 'player'
require_relative 'cpu'
require_relative 'results'

class Game
  attr_reader :card_deck
  attr_accessor :players, :current_player, :started, :cpu_arr, :results

  def initialize
    @started = false
    @card_deck = CardDeck.new
    @players = []
    @current_player = nil
  end

  def create_cpu(cpu_number)
    cpu_number.times do |index| 
      players << CPU.new(players, "CPU#{index + 1}")
    end
    start
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
    if players.count > 1
      self.started = true
      card_deck.shuffle
      deal_count
      deal
      self.current_player = players[0]
    end
  end

  def cpu_take_turn
    rank = current_player.return_rank
    player = current_player.return_player
    take_turn(current_player, player, rank)
  end

  def take_turn(asking_player, asked_player, rank)
    if asked_player.has_rank?(rank)
      player_takes_card(asking_player, asked_player, rank)
    else
      player_go_fish(asking_player, asked_player, rank)
    end
    return cpu_take_turn if current_player.bot? 
  end

  # private

  def player_takes_card(asking_player, asked_player, rank)
    result = Results.new(asking_player, asked_player, rank)
    given_cards = asked_player.remove_cards_from_hand(rank)
    asking_player.add_players_cards_to_hand(given_cards)
    asking_player.count_matches
    self.results = result.player_results[:take_message]
  end

  def player_go_fish(asking_player, asked_player, rank)
    result = Results.new(asking_player, asked_player, rank)
    new_card = go_fish(asking_player)
    asking_player.count_matches
    output_message = player_fished_asked_rank(asking_player, asked_player, new_card, rank)
    self.results = output_message
  end

  def player_fished_asked_rank(asking_player, asked_player, new_card, rank)
    result = Results.new(asking_player, asked_player, rank)
    if new_card.rank == rank
      self.current_player = asking_player
      result.player_results[:fished_asked_rank_message]
    else
      advance_player
      result.player_results[:go_fish_message]
    end
  end

  def go_fish(player)
    new_card = card_deck.deal
    player.add_cards_to_hand(new_card)
    new_card
  end

  def advance_player
    if current_player == players.last
      self.current_player = players[0]
    else
      self.current_player = players[players.index(current_player) + 1]
    end
  end

  def deck_size(card_deck, player)
    deck_size = card_deck.count
    deck_size >= 5 ? deck_count(5, player) : deck_count(deck_size, player)
  end

  def deck_count(deck_size, player)
    deck_size.times do
      player.add_cards_to_hand(card_deck.deal)
    end
  end

  def bot?
    current_player != players[0] ? true : false
  end
end