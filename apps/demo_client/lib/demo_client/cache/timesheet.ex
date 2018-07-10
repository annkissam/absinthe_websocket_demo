defmodule DemoClient.Cache.Timesheet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "timesheets" do
    field :employee_email, :string
    field :employee_id, :integer
    field :notes, :string

    timestamps()
  end

  @doc false
  def changeset(timesheet, attrs) do
    timesheet
    |> cast(attrs, [:notes, :employee_email, :employee_id])
    |> validate_required([:notes, :employee_email])
  end
end
