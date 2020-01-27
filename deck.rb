# frozen_string_literal: true

class Deck
  attr_reader :cards
  CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace'].freeze
  CARD_SUITS = %w[heart diamond club spade].freeze

  def initialize
    @cards = self.class.cards
  end

  def self.cards
    @cards = []
    CARD_VALUES.each do |value|
      CARD_SUITS.each do |suit|
        card = Card.new(suit, value)
        @cards << card
      end
    end
    @cards.shuffle!
  end
end
