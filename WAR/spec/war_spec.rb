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
  describe 'initializes' do
    it 'empty deck' do
      new_deck = Deck.new
      expect(new_deck.deck).to eq([])
    end
  end

  describe 'initializes'do
    it 'adds suits' do
      expect(Deck.suits).to eq([:spades, :diamonds, :clubs, :hearts])
    end
  end
  describe 'initializes'do
    it 'adds values' do
      expect(Deck.values).to eq([2,3,4,5,6,7,8,9,10,11,12,13,14])
    end
  end
  describe 'create_52_card_deck' do
    it 'adds 52 cards to the deck' do
      deck1 = Deck.new
      deck1.create_52_card_deck
      expect(deck1.deck.length).to eq(52)

      deck1.create_52_card_deck
      expect(deck1.deck.length).to eq(104)
    end
  end
  describe 'remove_card' do
    it 'removes a card from the deck' do
      deck1 = Deck.new
      deck1.create_52_card_deck
      expect(deck1.current_index).to eq(0)
      deck1.remove_card
      expect(deck1.current_index).to eq(1)
    end
  end
  describe 'remove_card' do
    it 'checks if a card object is returned' do
      deck1 = Deck.new
      deck1.create_52_card_deck
      expect(deck1.remove_card).to be_a(Card)
    end
  end

  context 'switches to the placeholder deck' do
    it 'checks if the index is zero' do
      deck1 = Deck.new
      deck1.create_52_card_deck
      expect(deck1.current_index).to eq(0)
      52.times do
        deck1.remove_card
      end
      expect(deck1.current_index).to eq(0)
    end
  end
  describe 'shuffle' do
    it 'returns a deck of the original size' do
      deck1 = Deck.new
      deck1.create_52_card_deck
      deck1.shuffle
      expect(deck1.deck.size).to eq(52)
    end
  end
end

describe War do
  describe "initializes" do
    it "War with two players and a full main deck" do
      new_game = War.new("sky", "fawn")
      expect(new_game.player1.name).to eq("sky")
      expect(new_game.player2.name).to eq("fawn")
    end
  end
  describe 'initializes' do
    it "with 26 cards in each player's deck" do
      new_game = War.new("sky", "fawn")
      expect(new_game.player1.hand.deck.count).to eq(26)
      expect(new_game.player2.hand.deck.count).to eq(26)
    end
  end
  describe 'initializes' do
    it "passes out all cards and ready to play game" do
      new_game = War.new("sky", "fawn")
      expect(new_game.pass_cards).to eq("ready to play")
    end
  end
  context 'Once a game is player' do
    xit "returns the winner of the game" do
      new_game = War.new("sky", "fawn")
      # check whether player1 or player2 has an empty array, then return the player with the non empty array
      expect(War.play_game).to eq("?")
    end
  end
end

