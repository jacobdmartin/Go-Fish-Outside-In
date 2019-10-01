require_relative '../../lib/player'

describe '#Player' do
  let(:five_of_hearts) {PlayingCard.new("5", "Hearts")}

  describe '#add_cards_to_hand' do
    it 'adds a card to a players hand' do
      player = Player.new("Gracie")
      player.add_cards_to_hand(five_of_hearts)
      expect(player.hand.count).to eq 1
    end
  end
end