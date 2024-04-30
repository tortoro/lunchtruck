defmodule LunchtruckWeb.TruckLiveTest do
  use LunchtruckWeb.ConnCase

  import Phoenix.LiveViewTest
  import Lunchtruck.BusinessesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_truck(_) do
    truck = truck_fixture()
    %{truck: truck}
  end

  describe "Index" do
    setup [:create_truck]

    test "lists all trucks", %{conn: conn, truck: truck} do
      {:ok, _index_live, html} = live(conn, ~p"/trucks")

      assert html =~ "Listing Trucks"
      assert html =~ truck.name
    end

    test "saves new truck", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/trucks")

      assert index_live |> element("a", "New Truck") |> render_click() =~
               "New Truck"

      assert_patch(index_live, ~p"/trucks/new")

      assert index_live
             |> form("#truck-form", truck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#truck-form", truck: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/trucks")

      html = render(index_live)
      assert html =~ "Truck created successfully"
      assert html =~ "some name"
    end

    test "updates truck in listing", %{conn: conn, truck: truck} do
      {:ok, index_live, _html} = live(conn, ~p"/trucks")

      assert index_live |> element("#trucks-#{truck.id} a", "Edit") |> render_click() =~
               "Edit Truck"

      assert_patch(index_live, ~p"/trucks/#{truck}/edit")

      assert index_live
             |> form("#truck-form", truck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#truck-form", truck: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/trucks")

      html = render(index_live)
      assert html =~ "Truck updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes truck in listing", %{conn: conn, truck: truck} do
      {:ok, index_live, _html} = live(conn, ~p"/trucks")

      assert index_live |> element("#trucks-#{truck.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#trucks-#{truck.id}")
    end
  end

  describe "Show" do
    setup [:create_truck]

    test "displays truck", %{conn: conn, truck: truck} do
      {:ok, _show_live, html} = live(conn, ~p"/trucks/#{truck}")

      assert html =~ "Show Truck"
      assert html =~ truck.name
    end

    test "updates truck within modal", %{conn: conn, truck: truck} do
      {:ok, show_live, _html} = live(conn, ~p"/trucks/#{truck}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Truck"

      assert_patch(show_live, ~p"/trucks/#{truck}/show/edit")

      assert show_live
             |> form("#truck-form", truck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#truck-form", truck: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/trucks/#{truck}")

      html = render(show_live)
      assert html =~ "Truck updated successfully"
      assert html =~ "some updated name"
    end
  end
end
