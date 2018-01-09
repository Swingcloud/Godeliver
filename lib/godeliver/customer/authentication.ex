defmodule Godeliver.Customer.Authentication do
  use Ecto.Schema
  import Ecto.Changeset
  alias Godeliver.Customer.{Authentication, User}
  alias Comeonin.Bcrypt

  schema "authentications" do
    field :email, :string
    field :password, :string
    field :password_confirmation, :string, virtual: true
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Authentication{} = authentication, attrs) do
    authentication
    |> cast(attrs, [:email, :password, :password_confirmation])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password, message: "does not match password")
    |> validate_required([:email, :password, :password_confirmation])
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hashpwsalt(password))
  end
  defp put_pass_hash(changeset), do: changeset
end
