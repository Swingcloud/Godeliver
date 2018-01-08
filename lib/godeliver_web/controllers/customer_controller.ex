defmodule GodeliverWeb.CustomerController do
  use GodeliverWeb, :controller
  alias Godeliver.Customers
  alias Godeliver.Customers.User

  def index(conn, _params) do
    users = Customers.list_users
    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Customers.get_user!(id)
    render conn, "show.html", user: user
  end

  def new(conn, _params) do
    changeset = Customers.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Customers.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User #{user.id} created successfully")
        |> redirect(to: customer_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "An error occured")
        |> render "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Customers.get_user!(id)
    changeset = Customers.change_user(user)
    render(conn, "edit.html", changeset: changeset, user: user)
  end

  def update(conn, %{"user" => user_params, "id" => id}) do
    user = Customers.get_user!(id)
    case Customers.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User #{user.id} updated successfully")
        |> redirect(to: customer_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "An error occured")
        |> render "edit.html", changeset: changeset, user: user
    end
  end
end
