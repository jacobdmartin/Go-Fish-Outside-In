require_relative '../../lib/game'
require_relative '../../lib/player'
require_relative '../../lib/card_deck'

describe 'Game' do
  let(:player_bob) {Player.new("Bob")}
  let(:player_steve) {Player.new("Steve")}
  let(:player_joe) {Player.new("Joe")}

  let(:five_of_hearts) {PlayingCard.new("5", "Hearts")}
  let(:eight_of_diamonds) {PlayingCard.new("8", "Diamonds")}
  let(:five_of_spades) {PlayingCard.new("5", "Spades")}

  def create_game_and_add_two_players
    @game = Game.new
    @game.add_player(player_bob)
    @game.add_player(player_steve)
  end

  def start_game_and_add_two_players
    @game = Game.new
    @game.add_player(player_bob)
    @game.add_player(player_steve)
    @game.current_player = @game.players[0]
  end

  def create_game_and_add_three_players
    @game = Game.new
    @game.add_player(player_bob)
    @game.add_player(player_steve)
    @game.add_player(player_joe)
  end

  def give_two_players_cards
    @game.players[0].add_cards_to_hand(five_of_hearts, eight_of_diamonds)
    @game.players[1].add_cards_to_hand(five_of_spades)
  end

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
      current_player = game.find_current_player(player)
      # expect(current_player.name).to eq 'You'
    end
  end

  describe '#deal' do
    it 'deals the deck' do
      create_game_and_add_two_players
      @game.start
      expect(@game.players[0].hand.count).to eq 7
    end
  end

  describe '#deal_count' do
    it 'deals 7 cards if there are two players' do
      create_game_and_add_two_players
      number_of_cards = @game.deal_count
      expect(@game.players.count).to eq 2
      expect(number_of_cards).to eq 7
    end

    it "deals 5 cards if there are more then two players" do
      create_game_and_add_three_players
      number_of_cards = @game.deal_count
      expect(@game.players.count).to eq 3
      expect(number_of_cards).to eq 5
    end
  end

  describe '#start' do
    it 'expects players to have cards because the game has started' do
      create_game_and_add_two_players
      @game.start
      expect(@game.players[0].hand.count).to eq 7
      expect(@game.started).to eq true
    end

    it 'expects players to have no cards because the game hasn\'t started' do
      game = Game.new
      player = Player.new("Obediah")
      game.add_player(player)
      expect(game.players[0].hand.count).to eq 0
    end
  end

  describe '#cpu_take_turn' do
    let(:cpu1) {CPU.new(@game.players, "CPU 1")}
    let(:cpu2) {CPU.new(@game.players, "CPU 2")}

    let(:ace_of_diamonds) {PlayingCard.new("Ace", "Diamonds")}
    let(:king_of_spades) {PlayingCard.new("King", "Spades")}
    let(:eight_of_clubs) {PlayingCard.new("8", "Clubs")}

    def create_cpu(*cpu)
      cpu.each {|cpu| @game.players << cpu}
    end

    def give_cpus_cards
      cpu1.add_cards_to_hand(ace_of_diamonds, king_of_spades)
      cpu2.add_cards_to_hand(eight_of_clubs)
    end

    it 'returns the asking_player the asked_player and the rank the cpu gave' do
      @game = Game.new
      create_cpu(cpu1, cpu2)
      give_cpus_cards
      @game.current_player = cpu1
      @game.cpu_take_turn
      expect(@game.players[0].hand).to eq 3 
    end
  end

  describe '#take_turn' do
    let(:jonathan) {Player.new("Jonathan")}
    let(:natalie) {Player.new("Natalie")}
    let(:game) {Game.new}

    let(:king_of_hearts) {PlayingCard.new("King", "Hearts")}
    let(:ten_of_diamonds) {PlayingCard.new("10", "Diamonds")}
    let(:king_of_spades) {PlayingCard.new("King", "Spades")}
    let(:ten_of_clubs) {PlayingCard.new("10", "Clubs")}
    let(:seven_of_hearts) {PlayingCard.new("7", "Hearts")}

    def jonathan_fishes_rank_asked_for
      jonathan.add_cards_to_hand(ten_of_clubs)
      game.player_fished_asked_rank(jonathan, natalie, ten_of_clubs, ten_of_diamonds.rank)
    end

    def jonathan_goes_fishing
      jonathan.add_cards_to_hand(seven_of_hearts)
    end

    before do
      game.players << jonathan
      game.players << natalie
      jonathan.add_cards_to_hand(king_of_hearts, ten_of_diamonds)
      natalie.add_cards_to_hand(king_of_spades)
    end

    context 'other player has the rank asked for' do
      it 'gives the player the card from the other player' do
        game.take_turn(jonathan, natalie, king_of_hearts.rank)
        expect(jonathan.hand).to include(king_of_spades)
      end

      it 'lets the current player go again' do
        game.current_player = jonathan
        expect(game.current_player.name).to eq "Jonathan"
      end
    end

    context 'other player doesn\'t have the rank asked for' do
      context 'player goes fishing' do
        context 'receive from the deck what they asked for' do

          it 'gives the player a new card from the deck that is the rank they asked for' do
            game.current_player = jonathan
            game.take_turn(jonathan, natalie, "10")
            jonathan_fishes_rank_asked_for
            expect(jonathan.hand).to include(ten_of_clubs)
          end
  
          it 'lets the current player go again' do
            game.current_player = jonathan
            expect(game.current_player.name).to eq "Jonathan"
          end  
        end

        context 'don\'t receive that they ask from from the deck' do

          it 'gives player a new card from the deck that isn\'t the rank they asked for' do
            game.current_player = jonathan
            game.take_turn(jonathan, natalie, "10")
            jonathan_goes_fishing
            expect(jonathan.hand).to include(seven_of_hearts)
            game.current_player = jonathan
            game.advance_player
            expect(game.current_player).to eq natalie
          end
        end
        context 'no more cards in the deck' do

          it 'advances to the next player' do
            game.current_player = jonathan
            game.advance_player
            expect(game.current_player).to eq natalie
          end
        end
      end
    end

    context 'made a match and now has no cards' do
      let(:david) {Player.new("David")}
      let(:martha) {Player.new("Martha")}

      let(:deck_with_three_cards) {card_deck = [king_of_hearts, ten_of_diamonds, five_of_hearts]}
      let(:deck_with_no_cards) {card_deck = []}

      def deck_with_five_cards
        card_deck = [king_of_hearts, king_of_spades, ten_of_clubs, ten_of_diamonds, five_of_hearts]
      end

      def deck_with_three_cards
        card_deck = [king_of_hearts, ten_of_diamonds, five_of_hearts]
      end

      def deck_with_no_cards
        card_deck = []
      end

      it 'the card deck has cards left, so the player draws five cards' do
        game.deck_size(deck_with_five_cards, david)
        expect(david.hand.count).to eq 5
      end

      it 'the card deck has cards, but not five, so the player draws all the cards left' do
        game.deck_size(deck_with_three_cards, david)
        expect(david.hand.count).to eq 3
      end

      it 'the card deck has no cards left, so the current player is advanced' do
        deck_size = game.deck_size(deck_with_no_cards, david)
        expect(david.hand.count).to eq 0
      end
    end
  end
end