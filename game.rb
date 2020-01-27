require_relative 'card'
require_relative 'deck'
require_relative 'user'
require_relative 'dealer'

$bank = 0
WIN_SCORE = 21


class Game
  def initialize
    greeting
  end

  def start_game
    raise 'Somebody lost all the money, see next time.' if !players_able_to_play?
    reset_game 
    deal_the_cards
    user_turn
  end

  def user_turn
    open_cards if players_reached_cards_limit?
    puts "Now it`s your turn, you have #{@user.score_sum} scores"
    attempts = 0
    begin
      puts "Make your choice:
      \t1.Check
      \t2.Get new card
      \t3.Open cards"
      choice = gets.to_i
      case choice
      when 1
        dealer_turn
      when 2
        @user.get_card(@deck)
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
    puts 'Now it`s dealer`s turn'
    sleep(5)
    if @dealer.score_sum < 17
      @dealer.get_card(@deck)
      puts 'Dealer got new card'
    else
      puts 'Dealer checked'
    end
    user_turn
  end

  def deal_the_cards
    @user.get_startup_cards(@deck)
    @dealer.get_startup_cards(@deck)
  end

  def open_cards
    @user.cards_info
    @dealer.cards_info
    if (!@user.in_range? && !@dealer.in_range?) || @user.score_sum == @dealer.score_sum
      puts 'Nobody wins, it`s draw!'
      draw
    elsif
      !@user.in_range? && @dealer.in_range?
      puts 'Dealer win!'
      dealer_win
    elsif
      @user.in_range? && !@dealer.in_range?
      puts 'User win!'
      user_win
    elsif
      @user.in_range? && @dealer.in_range? && @user.score_sum > @dealer.score_sum
      puts 'User win!'
      user_win
    elsif
      @user.in_range? && @dealer.in_range? && @user.score_sum < @dealer.score_sum
      puts 'Dealer win!'
      dealer_win
    end
    puts 'Want new game?(y/n)'
    answer = gets.chomp
    if answer == 'y'
      start_game
    else
      puts 'Ok, chicken!'
      return
    end
  end

  private

  def players_able_to_play?
    return true unless @user.money < BET || @dealer.money < BET
  end

  def draw
    @user.money += @user.bets_sum
    @dealer.money += @dealer.bets_sum
  end

  def user_win
    @user.money += $bank
  end

  def dealer_win
    @dealer.money += $bank
  end

  def reset_game
    $bank = 0
    @user.cards.clear
    @dealer.cards.clear
    @deck = Deck.new
  end

  def players_reached_cards_limit?
    @user.reached_cards_limit? && @dealer.reached_cards_limit?
  end

  def seed(user_name)
    @user = User.new(user_name)
    @dealer = Dealer.new
  end

  def greeting
    print 'Enter your name: '
    user_name = gets.chomp
    print "Hi, #{user_name}. Ready to start?(press any key to start or 'n' to quit: "
    answer = gets.strip
    return if answer == 'n'
    seed(user_name)
    start_game
  end
end