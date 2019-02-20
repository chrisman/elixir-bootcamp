defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck creates 52 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 52
  end

  test "shuffleing a deck randomizes it" do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)
  end
end
