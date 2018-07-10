defmodule DemoServer.Cache.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employees" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
