defmodule LunchtruckWeb.TruckLive.FormComponent do
  use LunchtruckWeb, :live_component

  alias Lunchtruck.Businesses

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage truck records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="truck-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Truck</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{truck: truck} = assigns, socket) do
    changeset = Businesses.change_truck(truck)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"truck" => truck_params}, socket) do
    changeset =
      socket.assigns.truck
      |> Businesses.change_truck(truck_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"truck" => truck_params}, socket) do
    save_truck(socket, socket.assigns.action, truck_params)
  end

  defp save_truck(socket, :edit, truck_params) do
    case Businesses.update_truck(socket.assigns.truck, truck_params) do
      {:ok, truck} ->
        notify_parent({:saved, truck})

        {:noreply,
         socket
         |> put_flash(:info, "Truck updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_truck(socket, :new, truck_params) do
    case Businesses.create_truck(truck_params) do
      {:ok, truck} ->
        notify_parent({:saved, truck})

        {:noreply,
         socket
         |> put_flash(:info, "Truck created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
