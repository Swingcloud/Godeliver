defmodule Godeliver.Repo.Migrations.CreateAuthentications do
  use Ecto.Migration

  def change do
    create table(:authentications) do
      add :email, :string
      add :password, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:authentications, [:email])
    create index(:authentications, [:user_id])
  end
end
