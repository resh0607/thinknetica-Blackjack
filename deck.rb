# frozen_string_literal: true

class Deck
  attr_reader :cards

  def initialize
    @cards = self.class.cards
  end

  def self.cards
    @cards = []
    Card::VALUES.each do |value|
      Card::SUITS.each do |suit|
        card = Card.new(suit, value)
        @cards << card
      end
    end
    @cards.shuffle!
  end
end
