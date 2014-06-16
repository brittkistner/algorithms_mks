require_relative 'linked_list.rb'


class Card
  # Rank is the rank of the card, 2-10, J, Q, K, A
  # Value is the numeric value of the card, so J = 11, A = 14
  # Suit is the suit of the card, Spades, Diamonds, Clubs or Hearts

  attr_reader :value, :suit, :rank
  def initialize(value, suit)
    @value = value
    @suit = suit
    @rank = make_rank(value)
  end

  def make_rank(value)
    case value
    when 11
      :J
    when 12
      :Q
    when 13
       :K
    when 14
       :A
    else
       value
    end
  end
end

class Deck

  attr_accessor :deck

  def initialize
    @deck = Linked_List.new
  end

  def create_52_card_deck_and_shuffle
    temp =[]
    Deck.suits.each do |suit|
      Deck.values.each do |value|
        temp << Card.new(value, suit)
      end
    end

    temp.each {|x| @deck.add_last(x)}
  end

  def self.suits
    [:spades, :diamonds, :clubs, :hearts]
  end

  def self.values
    [2,3,4,5,6,7,8,9,10,11,12,13,14]
  end

  # Given a card,insert it on the bottom your deck
  def add_card(card)
    @deck.add_last(card)
  end

  # Remove the top card from your deck and return it
  def remove_card
    @deck.remove_first.value
  end

  def count_deck
    @deck.count
  end

  def empty?
    @deck.count == 0
  end
end



class Player
  attr_reader :name
  attr_accessor :hand

  def initialize(name)
    @name = name
    @hand = Deck.new
  end

  def take_card(card) #take a card from the deck during set up
    @hand.add_card(card)
  end

  def has_cards? #checks if the deck is empty
    !@hand.empty?
  end

  def play_card #takes a card from deck and returns the value of the card
    @hand.remove_card
  end
end


class War

  attr_accessor :player1, :player2, :main_deck

  def initialize(player1, player2)
    @main_deck = Deck.new
    @main_deck.create_52_card_deck_and_shuffle
    # @main_deck.shuffle

    @player1 = Player.new(player1)
    @player2 = Player.new(player2)

    #think about while loop for times

    26.times do
      pass_cards
    end
  end

  def pass_cards
    card1 = @main_deck.remove_card #main_deck is passing out cards
    @player1.take_card(card1)
    card2 = @main_deck.remove_card
    @player2.take_card(card2)
  end

  def play_game
    turns = 0
    while @player1.has_cards? && @player2.has_cards?

      card1 = @player1.play_card
      card2 = @player2.play_card
      result = WarAPI.play_turn(@player1, card1, @player2, card2)
      result[@player1].each { |c| @player1.hand.add_card(c) }
      result[@player2].each { |c| @player2.hand.add_card(c) }
    end
    turns
  end

  def winner
    if @player1.hand.count_deck == 0
      "#{@player2.name} is the winner!"
    else
      "#{@player1.name} is the winner!"
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
