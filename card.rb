# frozen_string_literal: true

class Card
  attr_reader :suit
  attr_reader :value
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'jack', 'queen', 'king', 'ace'].freeze
  SUITS = %w[heart diamond club spade].freeze

  def initialize(suit, value)
    @suit = suit
    @value = value
  end
end
