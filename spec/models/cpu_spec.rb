require_relative '../../lib/cpu'
require_relative '../../lib/player'
require_relative '../../lib/playing_card'

describe 'CPU' do
  let(:cpu1) {CPU.new(@game.players, "CPU 1")}
  let(:cpu2) {CPU.new(@game.players, "CPU 2")}

  let(:ace_of_diamonds) {PlayingCard.new("Ace", "Diamonds")}
  let(:king_of_spades) {PlayingCard.new("King", "Spades")}
  let(:eight_of_clubs) {PlayingCard.new("8", "Clubs")}

  def create_cpu(*cpu)
    cpu.each {|cpu| @game.players << cpu}
  end

  def create_game
    @game = Game.new
  end

  def give_cpus_cards
    cpu1.add_cards_to_hand(ace_of_diamonds, king_of_spades)
    cpu2.add_cards_to_hand(eight_of_clubs)
  end

  describe '#cpu_return_rank' do

    it 'returns a rank that the cpu is asking for' do
      create_game
      create_cpu(cpu1, cpu2)
      give_cpus_cards
      rank = @game.players[0].return_rank
      expect(rank).to_not be_nil
    end
  end

  describe '#cpu_return_player' do
    it 'returns a rank that the cpu is asking for' do
      create_game
      create_cpu(cpu1, cpu2)
      give_cpus_cards
      player = @game.players[0].return_player
      expect(player).to_not be_nil
    end
  end
end