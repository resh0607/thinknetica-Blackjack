require_relative 'deck'

BET = 10
CARDS_LIMIT = 3

class Player
  attr_reader :name, :cards, :bets_sum
  attr_accessor :money
  def initialize(name, startmoney = 100)
    @name = name
    @money = startmoney
    @cards = []
    @bets_sum = 0
  end

  def get_startup_cards(deck)
    2.times { get_card(deck) }
    make_bet
  end

  def get_card(deck)
    raise 'You already have 3 cards,you can check or open cards!' if reached_cards_limit?
    card = deck.cards.slice!(rand(deck.cards.length - 1))
    @cards << card
  end

  def score_sum
    score_sum ||= 0
    @cards.each do |card|
      if card.value.is_a?(String)
        score_sum += 10
      else score_sum += card.value
      end
    end
    score_sum -= 9 if score_sum > 21 && ace_in_cards?
    score_sum += 1 if score_sum < 21 && ace_in_cards?
    return score_sum
  end

  def make_bet
    @money -= BET
    $bank += BET
    @bets_sum += BET
  end

  def ace_in_cards?
    return true if @cards.map(&:value).include?('ace')
  end

  def cards_info
    puts "#{self.class.to_s} cards are: "
    @cards.each { |card| puts "#{card.suit} - #{card.value}"}
    puts "Score sum is: #{score_sum}"
  end

  def reached_cards_limit?
    @cards.size == CARDS_LIMIT
  end

  def in_range?
    return true if score_sum <= 21
  end
end
