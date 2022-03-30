defmodule ExMon.Game.Action do
  alias ExMon.Game
  alias ExMon.Game.Actions.Attack
  alias ExMon.Game.Actions.Heal

  def attack(move) do
    case Game.turn() do
      :player -> Attack.attack_oponent(:computer, move)
      :computer -> Attack.attack_oponent(:player, move)
    end
  end

  def heal() do
    case Game.turn() do
      :player -> Heal.heal(:player)
      :computer -> Heal.heal(:computer)
    end
  end

  def fetch_move(move) do
    Game.player()
    |> Map.get(:moves)
    |> find_move(move)
  end

  defp find_move(moves, move) do
    Enum.find_value(moves, {:error, move}, fn {key, value} ->
      if value == move, do: {:ok, key}
    end)
  end

end
