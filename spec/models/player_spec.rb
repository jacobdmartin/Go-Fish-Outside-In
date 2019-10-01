require_relative '../../lib/player'
require_relative '../../lib/playing_card'

describe 'Player' do
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
end