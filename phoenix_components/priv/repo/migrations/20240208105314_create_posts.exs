defmodule PhoenixComponents.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :username, :string
      add :body, :string
      add :likes_counts, :integer
      add :reposts_count, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
