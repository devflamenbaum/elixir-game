defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.Game
  alias ExMon.Player

  describe "start/2" do
    test "start the game stage" do
      player = Player.build("Gabriel", :soco, :chute, :cura)
      computer = Player.build("Robotinik", :soco, :chute, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "return the current state" do
      player = Player.build("Gabriel", :soco, :chute, :cura)
      computer = Player.build("Robotinik", :soco, :chute, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{
            move_avg: :soco,
            move_heal: :cura,
            move_rnd: :chute
          },
          name: "Robotinik"
        },
        player: %Player{
          life: 100,
          moves: %{
            move_avg: :soco,
            move_heal: :cura,
            move_rnd: :chute
          },
          name: "Gabriel"
        },
        status: :started,
        turn: :player
      }


      assert Game.info() == expected_response
    end
  end

  describe "update/1" do
    test "return the game state updated" do
      player = Player.build("Gabriel", :soco, :chute, :cura)
      computer = Player.build("Robotinik", :soco, :chute, :cura)

      Game.start(computer, player)

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Robotinik"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Gabriel"
        },
        status: :started,
        turn: :player
      }

    Game.update(new_state)

    expected_response = %{new_state | turn: :computer, status: :continue}

    assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "Return current player" do
      player = Player.build("Gabriel", :soco, :chute, :cura)
      computer = Player.build("Robotinik", :soco, :chute, :cura)

      Game.start(computer, player)

      expected_response =  %Player{
                              life: 100,
                              moves: %{ move_avg: :soco, move_heal: :cura, move_rnd: :chute},
                              name: "Gabriel"
                            }

      assert Game.player() == expected_response
    end
  end

  describe "turn/0" do
    test "Return current turn" do
      player = Player.build("Gabriel", :soco, :chute, :cura)
      computer = Player.build("Robotinik", :soco, :chute, :cura)

      Game.start(computer, player)


      assert Game.turn() == :player
    end
  end

  describe "fetch_player/1" do
    test "Return player" do
      player = Player.build("Gabriel", :soco, :chute, :cura)
      computer = Player.build("Robotinik", :soco, :chute, :cura)

      Game.start(computer, player)

      expected_response =
        %Player{
          life: 100,
          moves: %{ move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Gabriel"
        }


      assert Game.fetch_player(:player) == expected_response
    end
  end
end
