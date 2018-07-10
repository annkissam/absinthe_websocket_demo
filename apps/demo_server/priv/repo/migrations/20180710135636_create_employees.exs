defmodule DemoServer.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :name, :string
      add :email, :string

      timestamps()
    end

  end
end
