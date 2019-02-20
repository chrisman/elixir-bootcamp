defmodule Cards do
  @moduledoc """
    Provides methods for creating and manipulating a deck of cards
  """

  @doc """
    Returns a string representing a deck of playing cards
  """
  def create_deck do
    faces = ["J", "Q", "K", "A"]
    numbers = [ 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
    suits = ["♠", "♣", "♥", "♦"]

    for suit <- suits, value <- Enum.concat(numbers, faces) do
      "#{value}#{suit}"
    end
  end

  @doc """
    Takes a deck and returns a randomized deck
  """
  def shuffle(deck) do
    Enum.shuffle deck
  end

  @doc """
    Determines whether a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "A♠")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates the number of cards that should be returned.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["2♠"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Takes a deck and a filename (string)
    Saves a deck to a filename
    Returns nothing
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Takes a filename. Returns the contents of that file. Or an error if that file doesn't exist.
  """
  def load(filename) do
    case File.read(filename) do
      { :ok, binary } ->
        :erlang.binary_to_term(binary)
      { :error, _reason } ->
        "The file #{filename} does not exist!"
    end
  end

  @doc """
    Takes a number `hand_size`. Creates a deck, shuffles it, and returns a hand of length `hand_size` and the rest of the deck.
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
