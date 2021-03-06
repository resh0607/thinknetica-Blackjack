# frozen_string_literal: true

class Hand
  attr_reader :cards
  CARDS_LIMIT = 3

  def initialize
    @cards = []
  end

  def get_startup_cards(deck)
    2.times { get_card(deck) }
  end

  def get_card(deck)
    if reached_cards_limit?
      raise 'You already have 3 cards,you can check or open cards!'
    end

    card = deck.cards.slice!(rand(deck.cards.length - 1))
    @cards << card
  end

  def score_sum
    score_sum ||= 0
    @cards.each do |card|
      score_sum += card.value.is_a?(String) ? 10 : card.value
    end
    score_sum -= 9 if score_sum > 21 && ace_in_cards?
    score_sum += 1 if score_sum < 21 && ace_in_cards?
    score_sum
  end

  def cards_info
    @cards.each { |card| puts "#{card.suit} - #{card.value}" }
    Interface.score_sum(score_sum)
  end

  def reached_cards_limit?
    @cards.size == CARDS_LIMIT
  end

  def in_range?
    return true if score_sum <= 21
  end

  private

  def ace_in_cards?
    return true if @cards.map(&:value).include?('ace')
  end
end
