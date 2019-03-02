defmodule Discuss.UserSocket do
  use Phoenix.Socket

  channel "comments:*", Discuss.CommentsChannel

  transport :websocket, Phoenix.Transports.WebSocket

  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, "key", token) do
      {:error, _error} ->
        :error
      {:ok, user_id} ->
        {:ok, assign(socket, :user_id, user_id)}
    end
  end

  def id(_socket), do: nil
end
