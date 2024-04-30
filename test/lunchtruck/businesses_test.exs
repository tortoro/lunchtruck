defmodule Lunchtruck.BusinessesTest do
  use Lunchtruck.DataCase

  alias Lunchtruck.Businesses

  describe "trucks" do
    alias Lunchtruck.Businesses.Truck

    import Lunchtruck.BusinessesFixtures

    @invalid_attrs %{name: nil}

    test "list_trucks/0 returns all trucks" do
      truck = truck_fixture()
      assert Businesses.list_trucks() == [truck]
    end

    test "get_truck!/1 returns the truck with given id" do
      truck = truck_fixture()
      assert Businesses.get_truck!(truck.id) == truck
    end

    test "create_truck/1 with valid data creates a truck" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Truck{} = truck} = Businesses.create_truck(valid_attrs)
      assert truck.name == "some name"
    end

    test "create_truck/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Businesses.create_truck(@invalid_attrs)
    end

    test "update_truck/2 with valid data updates the truck" do
      truck = truck_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Truck{} = truck} = Businesses.update_truck(truck, update_attrs)
      assert truck.name == "some updated name"
    end

    test "update_truck/2 with invalid data returns error changeset" do
      truck = truck_fixture()
      assert {:error, %Ecto.Changeset{}} = Businesses.update_truck(truck, @invalid_attrs)
      assert truck == Businesses.get_truck!(truck.id)
    end

    test "delete_truck/1 deletes the truck" do
      truck = truck_fixture()
      assert {:ok, %Truck{}} = Businesses.delete_truck(truck)
      assert_raise Ecto.NoResultsError, fn -> Businesses.get_truck!(truck.id) end
    end

    test "change_truck/1 returns a truck changeset" do
      truck = truck_fixture()
      assert %Ecto.Changeset{} = Businesses.change_truck(truck)
    end
  end
end
