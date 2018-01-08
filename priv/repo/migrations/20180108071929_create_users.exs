defmodule Godeliver.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :phone_number, :string

      timestamps()
    end

  end
end
