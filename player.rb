require_relative 'deck'

class Player
  attr_reader :money, :name, :cards
  def initialize(name, startmoney = 100)
    @name = name
    @money = startmoney
    @cards = []
  end

  def get_startup_cards(deck)
    2.times { get_card(deck) }
    make_bet
  end

  def get_card(deck)
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
    @money -= 10
    $bank += 10
  end

  def ace_in_cards?
    return true if @cards.map(&:value).include?('ace')
  end

  def cards_info
    @cards.each { |card| puts "#{card.suit} - #{card.value}"}
    puts "Score sum is: #{score_sum}"
  end
end
