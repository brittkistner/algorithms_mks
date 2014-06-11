# This class is complete. You do not need to alter this
class Card
  # Rank is the rank of the card, 2-10, J, Q, K, A
  # Value is the numeric value of the card, so J = 11, A = 14
  # Suit is the suit of the card, Spades, Diamonds, Clubs or Hearts

  attr_reader :value, :suit, :rank
  def initialize(value, suit) #consider adding the rank back in
    @value = value
    @suit = suit
    @rank = make_rank(value)
  end

  def make_rank(value)
    case value
      when 11
        return :J
      when 12
        return :Q
      when 13
        return :K
      when 14
        return :A
      else
        return value
    end
  end
end

class Deck
  def self.suits
    [:spades, :diamonds, :clubs, :hearts]
  end

  def self.values
    [2,3,4,5,6,7,8,9,10,11,12,13,14]
  end

  attr_accessor :deck, :current_index
  attr_reader :ph

  def initialize
    @deck = [] # Determine the best way to hold the cards
    @ph = [] #ph = placeholder array
    @current_index = 0
  end

  # Given a card, insert it on the bottom your deck
  def add_card(card)
    @ph << card
  end

  # Mix around the order of the cards in your deck
  def shuffle # You can't use .shuffle!
    @deck.size.times do |i|
      j = rand(deck.size)
      @deck[i], @deck[j] = @deck[j], @deck[i]
    end
  end

  # Remove the top card from your deck and return it
  def remove_card
    card = @deck[@current_index]  #the first time around, this would be @deck[0]
    @deck[@current_index] = nil #now the first element is nil
    @current_index += 1 #increment the index by 1
    check_array
    return card
  end

  # Reset this deck with 52 cards
  def create_52_card_deck
    Deck.suits.each do |suit|
      Deck.values.each do |value|
        @deck << Card.new(value, suit)
      end
    end
  end

  def check_array
    if @deck[@current_index] == nil
      @deck = @ph
      @current_index = 0
      @ph = []
    end
  end

  def empty?
    @deck.count {|x| x!=nil} == 0
  end

  def count_deck
    @deck.count {|x| x!=nil}
  end
end

class Player
  attr_reader :name
  attr_accessor :hand
  def initialize(name)
    @name = name
    @hand = Deck.new
  end
  def give_card(card)
    @hand.deck << card
  end
  def has_cards?
    !@hand.empty?
  end

  # def play_card
  #   @hand.remove_card
  # end
end


class War

  attr_accessor :player1, :player2, :main_deck

  def initialize(player1, player2)
    @main_deck = Deck.new
    @main_deck.create_52_card_deck
    @main_deck.shuffle

    @player1 = Player.new(player1)
    @player2 = Player.new(player2)

    pass_cards
  end

  def pass_cards
    while !@main_deck.empty?
      card1 = @main_deck.remove_card
      @player1.give_card(card1)
      card2 = @main_deck.remove_card
      @player2.give_card(card2)
    end
  end

  def play_game
    while @player1.has_cards? && @player2.has_cards?
      card1 = @player1.hand.remove_card #play_card
      card2 = @player2.hand.remove_card
      result = WarAPI.play_turn(@player1, card1, @player2, card2)
      result[@player1].each { |c| @player1.hand.add_card(c) }
      result[@player2].each { |c| @player2.hand.add_card(c) }
      # if hash[@player1].length == 2  Use @ because a player object was passed through
      #   hand.add_card(hash[@player1][0])
      #   hand.add_card(hash[@player1][1])
      # else
      #   hand.add_card(hash[@player1][0])
      #   hand.add_card(hash[@player1][1])
      # end
    end
    if @player1.hand.empty?
      return "#{@player2.name} is the winner!"
    else
      return "#{@player1.name} is the winner!"
    end
  end
end


class WarAPI
  # This method will take a card from each player and
  # return a hash with the cards that each player should receive
  def self.play_turn(player1, card1, player2, card2)
    if card1.value > card2.value
      {player1 => [card1, card2], player2 => []}
    elsif card2.value > card1.value
      {player1 => [], player2 => [card2, card1]}
    elsif rand(100).even?
      {player1 => [], player2 => [card2, card1]}
    else
      {player1 => [card1, card2], player2 => []}
    end
  end
end
