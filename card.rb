# frozen_string_literal: true

class Card
  attr_reader :suit
  attr_reader :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end
end
