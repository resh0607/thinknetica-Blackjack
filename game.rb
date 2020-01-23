require_relative 'card'
require_relative 'deck'
require_relative 'user'
require_relative 'dealer'
$bank = 0

class Game

  def initialize
  end

  def start_game
    print 'Enter your name: '
    user_name = gets.chomp
    seed(user_name)
    print "Ready to start?(press any key to start or 'n' to quit: "
    answer = gets.strip
    return if answer == 'n'
    deal_the_cards
    puts 'Your cards are:'
    @user.cards_info
    choose
  end

  def choose
    puts "Make your choice:
    \t1.Check
    \t2.Get new card
    \t3.Open cards"
    choise = gets.to_i
    case choice
    when 1
      check
    when 2
      get_new_card
    when 3
      open_cards
    end
  end

  def seed(user_name)
    @user = User.new(user_name)
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def deal_the_cards
    @user.get_startup_cards(@deck)
    @dealer.get_startup_cards(@deck)
  end

  private 

  def new_deck
    @deck = []
    CARD_VALUES.each do |value|
      CARD_SUITS.each do |suit|
        card = Card.new(suit, value)
        @deck << card
      end
    end
    return @deck
  end
end