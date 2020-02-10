# frozen_string_literal: true

class Player
  attr_reader :name, :bets_sum, :hand
  attr_accessor :money

  def initialize(name, startmoney = 100)
    @name = name
    @money = startmoney
    @bets_sum = 0
    @hand = Hand.new
  end

  def make_bet
    @money -= BET
    $bank += BET
    @bets_sum += BET
  end
end
