defmodule DemoClient.Repo.Migrations.CreateTimesheets do
  use Ecto.Migration

  def change do
    create table(:timesheets) do
      add :notes, :text
      add :employee_email, :string
      add :employee_id, :integer

      timestamps()
    end

  end
end
