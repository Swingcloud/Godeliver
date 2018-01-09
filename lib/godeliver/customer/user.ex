defmodule Godeliver.Customer.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Godeliver.Customer.{User, Authentication}


  schema "users" do
    field :name, :string
    field :phone_number, :string
    has_one :authentication, Authentication

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :phone_number])
    |> validate_required(:phone_number)
    |> validate_length(:phone_number, is: 8, message: 'need to be 8 digits')
  end
end
