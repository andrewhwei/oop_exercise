# 1. Write out the Card and Deck classes to make the program work. The Deck class should hold a list of Card instances.
# 2. Change the program to use multiple choice questions. The Card class should be responsible for checking the answer.
# 3. CHALLENGE: Change the program to allow the user to retry once if they get the wrong answer.
# 4. CHALLENGE: Change the program to keep track of number right/wrong and give a score at the end.
# 5. CHALLENGE: Change the program to give the user the choice at the end of the game to retry the cards they got wrong.
# 6. CHALLENGE: Change the interface with better prompts, ASCII art, etc. Be as creative as you'd like!

class Card
  attr_reader :question, :answers, :choices, :no_of_incorrect_tries, :user_answer_correct

  def initialize(question, answers)
    @question = question
    @answers = answers
    @choices = answers.shuffle
    @no_of_incorrect_tries = 0
    @user_answer_correct = 0
  end

  def check_answer
    while @no_of_incorrect_tries <= 1 && @user_answer_correct == 0
      if gets.chomp.downcase == @answers[0].downcase
        puts "Correct!"
        @user_answer_correct = 1
      elsif @no_of_incorrect_tries <= 1
        puts "Incorrect! Try again!"
        @no_of_incorrect_tries += 1
      else
        puts "Incorrect!"
        @no_of_incorrect_tries += 1
      end
    end
  end
end

class Deck
  attr_reader :remaining_cards

  def initialize(trivia_data)
    @cards = []

    if trivia_data != nil
      trivia_data.each do |question, answers|
        @cards.push(Card.new(question, answers))
      end
    end

    @remaining_cards = @cards.size
  end

  def draw_card
    @remaining_cards -= 1
    return @cards.pop
  end
end

class Gamestate
  attr_reader :second_try_questions, :no_correct_answers, :no_incorrect_answers

  def initialize
    @second_try_questions = {}
    @no_correct_answers = 0
    @no_incorrect_answers = 0
  end

  def tally_score(user_answer_correct, no_of_incorrect_tries)
    @no_correct_answers += user_answer_correct
    @no_incorrect_answers += no_of_incorrect_tries
  end

  def start_game(deck, first_try)
    while deck.remaining_cards > 0
      card = deck.draw_card # card is an instance of the Card class
      puts 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr
      puts card.question
      puts "Pick an answer from the following:"
      puts card.choices
      card.check_answer
      tally_score(card.user_answer_correct, card.no_of_incorrect_tries)

      if first_try && card.no_of_incorrect_tries == 2
        @second_try_questions[card.question] = card.answers
      end
    end
  end
end

trivia_data = {
  "What is the capital of Illinois?" => ["Springfield", "Sacramento", "San Jose", "San Francisco"],
  "Is Africa a country or a continent?" => ["Continent", "Country"],
  "Tug of war was once an Olympic event. True or false?" => ["True", "False"]
}
gamestate = Gamestate.new
deck = Deck.new(trivia_data)
gamestate.start_game(deck, true)
puts 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr
puts "Welcome to the redemption round."
second_try_deck = Deck.new(gamestate.second_try_questions)
gamestate.start_game(second_try_deck, false)


puts "You answered #{gamestate.no_correct_answers} questions correctly and had #{gamestate.no_incorrect_answers} incorrect attempts. Thanks for playing!"







