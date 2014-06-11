require 'rubygems'
require 'rspec'
require 'pry-debugger'
require_relative '../war.rb'

describe Card do
  it 'checks the value, suit and rank of a card' do
    card = Card.new(11, :diamonds)
    expect(card.value).to eq(11)
    expect(card.suit).to eq(:diamonds)
    expect(card.rank).to eq(:J)
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
    it 'adds values' do
      expect(Deck.values).to eq([2,3,4,5,6,7,8,9,10,11,12,13,14])
    end
  end
  describe 'create_52_card_deck' do
    it 'adds 52 cards to the deck' do
      deck1 = Deck.new
      deck1.create_52_card_deck
      expect(deck1.deck.length).to eq(52)
    end
    it 'adds another deck to a created deck'do
      deck1 = Deck.new
      deck1.create_52_card_deck
      expect(deck1.deck.length).to eq(52)

      deck1.create_52_card_deck
      expect(deck1.deck.length).to eq(104)
    end
  end
  describe 'remove_card and add_card' do
    it 'adds card then removes card' do
      deck1 = Deck.new
      expect(deck1.deck.length).to eq(0)
      deck1.add_card(3)
      expect(deck1.ph.length).to eq(1) #can't include both add and remove, since add cards go to ph
      # deck1.remove_card
      # expect(deck1.count_deck).to eq(0)
    end
  end
  describe 'remove_card' do
    it 'removes card from deck' do
      deck1 = Deck.new
      deck1.create_52_card_deck
      expect(deck1.count_deck).to eq(52)
      deck1.remove_card
      expect(deck1.count_deck).to eq(51) #can't include both add and remove, since add cards go to ph
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
    it "War with two players" do
      new_game = War.new("sky", "fawn")
      expect(new_game.player1.name).to eq("sky")
      expect(new_game.player2.name).to eq("fawn")
    end

    it "with 26 cards in each player's deck" do
      new_game = War.new("sky", "fawn")
      expect(new_game.player1.hand.count_deck).to eq(26) #index = 0
      expect(new_game.player2.hand.count_deck).to eq(26)
    end
  end

  describe "pass_cards" do
    it "empties main deck and passes cards to all players" do
      new_game = War.new("sky", "fawn")
      new_game.pass_cards
      expect(new_game.main_deck.count_deck).to eq(0)
    end
  end

  describe "play_game" do
    xit "the winner will have 52 cards and the loser will have 0 cards" do
      new_game = War.new("sky", "fawn")
      new_game.play_game
      # expect(winner).to be_a(Person)
      if new_game.player1.hand.empty?
        expect(new_game.player2.hand.ph.count).to eq(52)
        expect(new_game.player1.hand.count_deck).to eq(0)
      else
        expect(new_game.player1.hand.ph.count).to eq(52)
        expect(new_game.player2.hand.count_deck).to eq(0)
      end
    end
  end
end

