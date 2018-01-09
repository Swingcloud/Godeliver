defmodule GodeliverWeb.Customer.UserController do
  use GodeliverWeb, :controller
  alias Godeliver.Customer
  alias Godeliver.Customer.User

  def index(conn, _params) do
    users = Customer.list_users
    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Customer.get_user!(id)
    render conn, "show.html", user: user
  end

  def new(conn, _params) do
    changeset = Customer.change_user(%User{})
    render(conn, "new.html", changeset: changeset, action: user_path(conn, :create))
  end

  def create(conn, %{"user" => user_params}) do
    case Customer.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User #{user.id} created successfully")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "An error occured")
        |> render("new.html", changeset: changeset, action: user_path(conn, :create))
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Customer.get_user!(id)
    changeset = Customer.change_user(user)
    render(conn, "edit.html", changeset: changeset, action: user_path(conn, :update, user.id), user: user)
  end

  def update(conn, %{"user" => user_params, "id" => id}) do
    user = Customer.get_user!(id)
    case Customer.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User #{user.id} updated successfully")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "An error occured")
        |> render("edit.html", changeset: changeset, action: user_path(conn, :update, user.id), user: user)
    end
  end
end
