require_relative '../../lib/player'
require_relative '../../lib/playing_card'

describe 'Player' do
  let(:player_james) {Player.new("James")}
  let(:player_grace) {Player.new("Grace")}

  let(:five_of_hearts) {PlayingCard.new("5", "Hearts")}
  let(:eight_of_diamonds) {PlayingCard.new("8", "Diamonds")}
  let(:five_of_spades) {PlayingCard.new("5", "Spades")}

  describe '#add_cards_to_hand' do
    it 'adds a card to a players hand' do
      player = Player.new("Gracie")
      player.add_cards_to_hand(five_of_hearts)
      expect(player.hand.count).to eq 1
    end
  end

  describe '#unique_ranks' do
    it 'returns one unique rank of each of the players ranks in hand' do
      player_bob = Player.new("Bob")
      player_bob.add_cards_to_hand(five_of_hearts, eight_of_diamonds, five_of_spades)
      expect(player_bob.unique_ranks).to eq ["5", "8"]
    end
  end

  describe '#has_rank?' do
    it 'returns true if the player has the rank asked for' do
      player_grace.add_cards_to_hand(five_of_hearts, eight_of_diamonds)
      expect(player_grace.has_rank?("5")).to eq true    
    end

    it 'returns false if the player does not have the rank asked for' do
      player_james.add_cards_to_hand(five_of_hearts)
      expect(player_grace.has_rank?("8")).to eq false
    end
  end

  describe '#remove_cards_from_hand' do
    it 'removes the card from the players hand' do
      
    end
  end

  describe '#count_matches' do
    it 'looks at the number of each rank in a players hand to see if they have any matches' do

    end
  end
end