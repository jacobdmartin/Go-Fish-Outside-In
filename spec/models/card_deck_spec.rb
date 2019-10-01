require_relative '../../lib/card_deck'

describe '#CardDeck' do

  describe '#shuffle' do
    it 'shuffles the deck' do
      card_deck1 = CardDeck.new
      card_deck2 = CardDeck.new
      card_deck1.shuffle
      expect(card_deck1).to_not eq(card_deck2)
    end
  end

  describe '#deal' do
    it 'deals a single card to a player' do
      deck = CardDeck.new
      player = Player.new("James")
      player.hand << deck.deal
      expect(player.hand.count).to eq 1
      expect(deck.card_deck.count).to eq 51
    end
  end

  describe '#provide_deck' do
    it 'stocks the deck with cards' do
      deck = CardDeck.new
      expect(deck.card_deck.count).to eq 52 
    end
  end
end