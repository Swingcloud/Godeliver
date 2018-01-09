defmodule Godeliver.SessionController do
  use GodeliverWeb, :controller

  alias Godeliver.Customer

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Customer.authenticate_user(email, password) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "welcome back!")
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: "/users")
      {:error, error} ->
        conn
        |> put_flash(:error, error)
        |> redirect(to: "/users")
    end
  end

  def delete(conn, _) do
    conn
    |> Guardian.sign_out()
    |> configure_session(drop: true)
    |> redirect(to: "/users")
  end
end
