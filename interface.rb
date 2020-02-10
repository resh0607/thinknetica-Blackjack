# frozen_string_literal: true

class Interface
  class << self
    def welcome_message(user_name)
      puts "Hi, #{user_name}. Ready to start?(press any key to start or 'n' to quit): "
      answer = gets.strip
      return if answer == 'n'
    end

    def ask(question)
      print question + ' '
      gets.chomp
    end

    def turn(player)
      puts "Now it`s #{player.name} turn."
      puts "Score: #{player.hand.score_sum} scores" if player.is_a?(User)
    end

    def show_menu
      puts "Make your choice:
        \t1.Check
        \t2.Get new card
        \t3.Open cards"
    end

    def got_card(player)
      puts "#{player.name} got new card"
    end

    def checked(player)
      puts "#{player.name} checked"
    end

    def show_winner(player)
      puts "#{player.name} win.\nTotal money: #{player.money}"
    end

    def say_bye
      puts 'Ok, see you next time!'
    end

    def draw
      puts 'Nobody wins, it`s draw!'
    end

    def no_money
      puts 'Somebody lost all the money, see next time.'
    end

    def cards_info(player)
      puts "#{player.name}`s cards: #{player.hand.cards_info}"
    end
  end
end
