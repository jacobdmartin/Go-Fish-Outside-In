require_relative '../../lib/game'

describe '#Game' do
  let(:player_bob) {Player.new("Bob")}
  let(:player_steve) {Player.new("Steve")}
  let(:player_joe) {Player.new("Joe")}

  describe '#create_cpu' do
    it 'creates a cpu and adds it to the players array' do
      cpu_number = 3
      game = Game.new
      game.create_cpu(cpu_number)
      expect(game.players.count).to eq 3
    end
  end

  describe '#add_player' do
    it 'adds a player to the players array' do
      game = Game.new
      player = Player.new("Jimmy")
      game.add_player(player)
      expect(game.players.count).to eq 1
      expect(game.players[0].name).to eq "Jimmy"
    end
  end

  describe '#empty?' do
    it 'returns true because the players array is empty' do
      game = Game.new
      expect(game.empty?).to eq true
    end

    it 'returns false because the players array contains players' do
      game = Game.new
      player = Player.new("Jenny")
      game.add_player(player)
      expect(game.empty?).to eq false
    end
  end

  describe '#find_current_player' do
    it 'expects player 1 to be the current player' do
      game = Game.new
      player = Player.new('You')
      game.add_player(player)
      current_arr = game.find_current_player(player)
      current_player = current_arr.pop
      expect(current_player.name).to eq 'You'
    end
  end

  describe '#deal' do
    it 'deals the deck' do
      game = Game.new
      game.deal
    end
  end

  describe '#deal_count' do
    it 'deals 7 cards if there are two players' do
      game = Game.new
      game.add_player(player_bob)
      game.add_player(player_steve)
      number_of_cards = game.deal_count
      expect(game.players.count).to eq 2
      expect(number_of_cards).to eq 7
    end

    it "deals 5 cards if there are more then two players" do
      game = Game.new
      game.add_player(player_bob)
      game.add_player(player_steve)
      game.add_player(player_joe)
      number_of_cards = game.deal_count
      expect(game.players.count).to eq 3
      expect(number_of_cards).to eq 5
    end
  end

  describe '#start' do
    it 'expects players to have cards because the game has started' do
      game = Game.new
      player = Player.new("John")
      game.add_player(player)
      game.start
      expect(player.hand.count).to eq 7
      expect(game.started).to eq true
    end

    it 'expects players to have no cards because the game hasn\'t started' do
      game = Game.new
      player = Player.new("Obediah")
    end
  end
end