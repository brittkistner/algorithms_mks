require 'rubygems'
require 'rspec'
require 'pry-debugger'
require_relative '../war_ll.rb'


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
      @deck1 = Deck.new
    end
    it 'deck has no cards' do
      expect(@deck1.count_deck).to eq(0)
    end
  end

  describe '#create_52_card_deck' do
    before do
      @deck1 = Deck.new
    end
    xit 'adds 52 cards to the deck' do
      @deck1.create_52_card_deck
      expect(@deck1.count_deck).to eq(52)
    end
  end

  describe '#add_card and #remove_card' do
    before do
      @deck1 = Deck.new
    end
    it 'adds card then removes card' do
      expect(@deck1.count_deck).to eq(0)

      @deck1.add_card(3)
      expect(@deck1.count_deck).to eq(1)

      @deck1.remove_card
      expect(@deck1.count_deck).to eq(0)
    end
  end

  describe 'shuffle' do
    xit 'returns a deck of the original size' do
      # deck1 = Deck.new
      # deck1.create_52_card_deck
      # deck1.shuffle
      # expect(deck1.deck.size).to eq(52)
    end
  end
end

describe 'Player' do

  describe "#initialize" do
    it 'has a name' do
      player1 = Player.new("p1")
      expect(player1.name).to eq("p1")
    end
  end

  # describe "#take_card and checks if #has_cards" do
  #   player1 = Player.new("p1")
  #   expect(player1.has_cards?).to eq(false)

  #   player1.take_card(1)
  #   expect(player1.hand.count_deck).to eq(1)

  #   expect(player1.has_cards?).to eq(true)
  # end

  # describe "#play_card" do
  #   player1 = Player.new("p1")

  #   player1.take_card(1)

  #   expect(player1.play_card).to eq(1)
  # end
end

describe "War" do
  describe "#initialize" do
    before do
      @new_game = War.new("p1", "p2")
    end
    xit "War with two players" do
      expect(@new_game.player1.name).to eq("p1")
      expect(@new_game.player2.name).to eq("p2")
    end

    xit "initializes with 26 cards in each player's deck" do
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
    xit "the winner will have 52 cards and the loser will have 0 cards" do
      @new_game.play_game

      if @new_game.player1.hand.count_deck == 0
        expect(@new_game.player2.hand.count_deck).to eq(52)
        expect(@new_game.player1.hand.count_deck).to eq(0)
      else
        expect(@new_game.player1.hand.count_deck).to eq(52)
        expect(@new_game.player2.hand.count_deck).to eq(0)
      end
    end

    xit "will return with the number of turns for the game" do
      allow(@new_game).to receive(:turns).and_return(15)
      expect(@new_game.turns).to eq(15)
    end
  end

  describe "#winner" do
    xit "will return the winner of the game" do
      new_game = War.new("p1", "p2")

      if new_game.player1.hand.count_deck == 0
        expect(new_game.winner).to eq("p2 is the winner!")
      else
        expect(new_game.winner).to eq("p1 is the winner!")
      end
    end
  end
end

