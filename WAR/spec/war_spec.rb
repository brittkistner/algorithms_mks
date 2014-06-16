require 'rubygems'
require 'rspec'
require 'pry-debugger'
require_relative '../war.rb'

describe "Card" do
  describe '#initialize' do
    it 'checks the value, suit and rank of a card' do
      card = Card.new(11, :diamonds)
      expect(card.value).to eq(11)
      expect(card.suit).to eq(:diamonds)
      expect(card.rank).to eq(:J)
    end
  end
end

describe "Deck" do
  describe '#initialize' do
    before do
      @new_deck = Deck.new
    end
    it 'deck is empty' do
      expect(@new_deck.deck.length).to eq(0)
    end
    it 'has an empty placeholder deck' do
      expect(@new_deck.ph.length).to eq(0)
    end

    it 'the current_index is set to 0' do
      expect(@new_deck.current_index).to eq(0)
    end
    it 'adds suits' do
      expect(Deck.suits).to eq([:spades, :diamonds, :clubs, :hearts])
    end
    it 'adds values' do
      expect(Deck.values).to eq([2,3,4,5,6,7,8,9,10,11,12,13,14])
    end
  end
  describe '#create_52_card_deck' do
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
  describe '#remove_card and #add_card' do
    it 'removes card from 52 card deck and adds card to placeholder deck' do
      deck1 = Deck.new
      deck1.create_52_card_deck
      expect(deck1.count_deck).to eq(52)
      deck1.remove_card
      expect(deck1.count_deck).to eq(51)

      deck1.add_card(3)
      expect(deck1.ph.length).to eq(1)
    end
  end

  # context 'switches to the placeholder deck' do
  #   xit 'checks if the index is zero' do
  #     deck1 = Deck.new
  #     deck1.create_52_card_deck
  #     expect(deck1.current_index).to eq(0)
  #     52.times do
  #       deck1.set_up_deck
  #     end
  #     expect(deck1.current_index).to eq(0)
  #   end
  # end

  describe 'shuffle' do
    it 'returns a deck of the original size' do
      deck1 = Deck.new
      deck1.create_52_card_deck
      deck1.shuffle
      expect(deck1.deck.size).to eq(52)
    end
  end
end

describe "War" do
  describe "#initialize" do
    before do
      @new_game = War.new("p1", "p2")
    end
    it "War with two players" do
      expect(@new_game.player1.name).to eq("p1")
      expect(@new_game.player2.name).to eq("p2")
    end

    it "initializes with 26 cards in each player's deck" do
      expect(@new_game.player1.hand.count_deck).to eq(26)
      expect(@new_game.player2.hand.count_deck).to eq(26)
    end
  end

  # describe "pass_cards" do
  #   it "empties main deck and passes cards to all players" do
  #     new_game = War.new("p1", "p2")

  #     new_game.pass_cards
  #     expect(new_game.main_deck.count_deck).to eq(0)
  #   end
  # end

  describe "#play_game" do
    before do
      @new_game = War.new("p1", "p2")
    end
    it "the winner will have 52 cards and the loser will have 0 cards" do
      @new_game.play_game

      if @new_game.player1.hand.count_deck == 0 && @new_game.player1.hand.count_ph == 0
        expect(@new_game.player2.hand.count_ph + @new_game.player2.hand.count_deck).to eq(52)
        expect(@new_game.player1.hand.count_ph + @new_game.player1.hand.count_deck).to eq(0)
      else
        expect(@new_game.player1.hand.count_ph + @new_game.player1.hand.count_deck).to eq(52)
        expect(@new_game.player2.hand.count_ph + @new_game.player2.hand.count_deck).to eq(0)
      end
    end

    it "will return with the number of turns for the game" do
      allow(@new_game).to receive(:turns).and_return(15)
      expect(@new_game.turns).to eq(15)
    end

    it "will return with the number of turns for the game" do
      num_turns = 0

      100.times do
      num_turns += @new_game.play_game
      end

      num_turns/100
    end
  end

  describe "#winner" do
    it "will return the winner of the game" do
      new_game = War.new("p1", "p2")

      new_game.play_game

      if new_game.player1.hand.count_deck == 0 && new_game.player1.hand.count_ph == 0
        expect(new_game.winner).to eq("p2 is the winner!")
      else
        expect(new_game.winner).to eq("p1 is the winner!")
      end
    end
  end
end

