# frozen_string_literal: true

require_relative 'interface'

class Game
  $bank = 0
  WIN_SCORE = 21

  def initialize
    greeting
  end

  def start_game
    unless players_able_to_play?
      Interface.no_money
      abort
    end

    reset_game
    deal_the_cards
    user_turn
  end

  def user_turn
    open_cards if players_reached_cards_limit?
    Interface.turn(@user)
    attempts = 0
    begin
      Interface.show_menu
      choice = gets.to_i
      case choice
      when 1
        dealer_turn
      when 2
        @user.hand.get_card(@deck)
        dealer_turn
      when 3
        open_cards
      end
    rescue RuntimeError => e
      puts "Ошибка: #{e.message}"
      attempts += 1
      retry if attempts < 3
    end
  end

  def dealer_turn
    Interface.turn(@dealer)
    sleep(3)
    if @dealer.hand.score_sum < 17
      @dealer.hand.get_card(@deck)
      Interface.got_card(@dealer)
    else
      Interface.checked(@dealer)
    end
    user_turn
  end

  def deal_the_cards
    @players.each do |player|
      player.hand.get_startup_cards(@deck)
      player.make_bet
    end
  end

  def open_cards
    # puts 'User`s cards are: '
    # @user.hand.cards_info
    # puts 'Dealer`s cards are: '
    # @dealer.hand.cards_info
    Interface.cards_info(@user)
    Interface.cards_info(@dealer)
    determine_winner
    answer = Interface.ask("Want new game?(type 'y' to continue)")
    if answer == 'y'
      start_game
    else
      Interface.say_bye
      abort
    end
  end

  def players_able_to_play?
    return true unless @user.money < BET || @dealer.money < BET
  end

  def draw
    Interface.draw
    @user.money += @user.bets_sum
    @dealer.money += @dealer.bets_sum
  end

  def user_win
    @user.money += $bank
    Interface.show_winner(@user)
  end

  def dealer_win
    @dealer.money += $bank
    Interface.show_winner(@dealer)
  end

  def reset_game
    $bank = 0
    @user.hand.cards.clear
    @dealer.hand.cards.clear
    @deck = Deck.new
  end

  def players_reached_cards_limit?
    @user.hand.reached_cards_limit? && @dealer.hand.reached_cards_limit?
  end

  def seed(user_name)
    @user = User.new(user_name)
    @dealer = Dealer.new
    @players = [@user, @dealer]
  end

  def greeting
    user_name = Interface.ask('What is your name?')
    Interface.welcome_message(user_name)

    seed(user_name)
    start_game
  end

  def determine_winner
    if draw_condition?
      draw
    elsif dealer_win_condition?     
      dealer_win
    elsif user_win_condition? 
      user_win
    end
  end

  def draw_condition?
    (!@user.hand.in_range? && !@dealer.hand.in_range?) || @user.hand.score_sum == @dealer.hand.score_sum
  end

  def dealer_win_condition?
    (!@user.hand.in_range? && @dealer.hand.in_range?) || (@user.hand.in_range? && @dealer.hand.in_range? && @user.hand.score_sum < @dealer.hand.score_sum)
  end

  def user_win_condition?
    (@user.hand.in_range? && !@dealer.hand.in_range?) || (@user.hand.in_range? && @dealer.hand.in_range? && @user.hand.score_sum > @dealer.hand.score_sum)
  end
end
