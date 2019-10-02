require_relative 'player'
require_relative 'game'

class Results
  attr_reader :game
  attr_accessor :player_results

  def initialize(inquiring_player, inquired_player, rank)
    @player_results = 
    { inquiring_player_take_rank_message: "#{inquiring_player.name} took a #{rank} from #{inquired_player.name}", 
      inquired_player_no_rank_message: "#{inquiring_player.name} asked for a #{rank} from #{inquired_player.name} but had to Go Fish", 
      inquiring_player_fished_rank: "#{inquiring_player.name} fished what they asked for, #{inquiring_player.name} take another turn" 
    }
  end
end