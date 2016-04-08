# 1. Write out the Card and Deck classes to make the program work. The Deck class should hold a list of Card instances.
# 2. Change the program to use multiple choice questions. The Card class should be responsible for checking the answer.
# 3. CHALLENGE: Change the program to allow the user to retry once if they get the wrong answer.
# 4. CHALLENGE: Change the program to keep track of number right/wrong and give a score at the end.
# 5. CHALLENGE: Change the program to give the user the choice at the end of the game to retry the cards they got wrong.
# 6. CHALLENGE: Change the interface with better prompts, ASCII art, etc. Be as creative as you'd like!

class Gamestate
  attr_reader :no_right, :no_wrong

  def initialize
    $no_right
    $no_wrong
  end

end


class Card
  attr_reader :question, :choices, :correct_answer, :no_of_tries, :user_answer_correct

  def initialize(question, answers)
    @question = question
    @correct_answer = answers[0]
    @choices = answers.shuffle
    @no_of_tries = 0
    @user_answer_correct = false
  end

  def check_answer(user_answer)
    if user_answer.downcase == @correct_answer.downcase
      puts "Correct!"
      @user_answer_correct = true
    elsif @no_of_tries <= 1
      puts "Incorrect! Try again!"
      @no_of_tries += 1
    else
      puts "Incorrect!"
      @no_of_tries += 1
    end
  end
end


class Deck
  attr_reader :remaining_cards, :no_right, :no_wrong, :second_attempt

  def initialize(trivia_data)
    @cards = []
    @no_right = 0
    @no_wrong = 0
    @second_attempt = []

    trivia_data.each do |question, answers|
      @cards.push(Card.new(question, answers))
    end

    @remaining_cards = @cards.size
  end

  def draw_card
    @remaining_cards -= 1
    return @cards.pop
  end

  def answered_correct
    @no_right += 1
  end

  def answered_incorrect
    @no_wrong += 1
  end
end

trivia_data = {
  "What is the capital of Illinois?" => ["Springfield", "Sacramento", "San Jose", "San Francisco"],
  "Is Africa a country or a continent?" => ["Continent", "Country"],
  "Tug of war was once an Olympic event. True or false?" => ["True", "False"]
}

deck = Deck.new(trivia_data) # deck is an instance of the Deck class

while deck.remaining_cards > 0
  card = deck.draw_card # card is an instance of the Card class
  puts 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr + 126.chr
  puts card.question
  puts "Pick an answer from the following: "
  puts card.choices
  while card.no_of_tries <= 1 && card.user_answer_correct == false
    card.check_answer(gets.chomp)
    if card.user_answer_correct
      deck.answered_correct
    else
      deck.answered_incorrect
    end
  end
end

puts "You answered #{deck.no_right} questions correctly and had #{deck.no_wrong} incorrect attempts. Thanks for playing!"














