require 'rubygems'
require 'rspec'
require 'pry-debugger'
require_relative '../war.rb'

describe Card do
  it 'checks the value, suit and rank of a card' do
    card = Card.new(11, :diamonds)
    expect(card.value).to eq(11)
    expect(card.suit).to eq(:diamonds)
    expect(card.rank). to eq(:J)
  end
end

describe Deck do
  it 'initializes an empty deck' do
    new_deck = Deck.new
    expect(new_deck.deck).to eq([])
  end

  it 'checks the suits in the deck' do
    expect(Deck.suits).to eq([:spades, :diamonds, :clubs, :hearts])
  end

  it 'checks the values in the deck' do
    expect(Deck.values).to eq([2,3,4,5,6,7,8,9,10,11,12,13,14])
  end

  it 'adds 52 cards to the deck' do
    deck1 = Deck.new
    deck1.create_52_card_deck
    expect(deck1.deck.length).to eq(52)

    deck1.create_52_card_deck
    expect(deck1.deck.length).to eq(104)
  end

  it 'removes a card from the deck' do
    deck1 = Deck.new
    deck1.create_52_card_deck
    expect(deck1.current_index).to eq(0)
    deck1.remove_card
    expect(deck1.current_index).to eq(1)
  end

  it 'checks if a card object is returned when remove card is called' do
    deck1 = Deck.new
    deck1.create_52_card_deck
    expect(deck1.remove_card).to be_a(Card)
  end

  it 'checks if the current index has switched to the placeholder deck and current index is 0' do
    deck1 = Deck.new
    deck1.create_52_card_deck
    expect(deck1.current_index).to eq(0)
    52.times do
      deck1.remove_card
    end
    expect(deck1.current_index).to eq(0)
  end

  it 'shuffles cards' do
    deck1 = Deck.new
    deck1.create_52_card_deck
    deck1.shuffle
    expect(deck1.deck.size).to eq(52)
  end
end

describe War do
  describe "initializes"
    it "War with two players and a full main deck" do
      new_game = War.new("sky", "fawn")
      expect(new_game.player1).to eq("sky")
      expect(new_game.player2).to eq("fawn")
    end
  describe 'initializes'
    it "with 26 cards in each player's deck" do
      expect(player1.hand.count).to eq(26)
      expect(player2.hand.count).to eq(26)
    end
  end
end

