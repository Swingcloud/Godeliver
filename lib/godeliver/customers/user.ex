defmodule Godeliver.Customers.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Godeliver.Customers.User


  schema "users" do
    field :name, :string
    field :phone_number, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :phone_number])
    |> validate_required :phone_number
    # |> validate_length(:phone_number, count: 8)
  end
end
