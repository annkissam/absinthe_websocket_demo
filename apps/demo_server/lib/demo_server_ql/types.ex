defmodule DemoServerQL.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: DemoServer.Repo

  object :employee do
    field :id, :id
    field :name, :string
    field :email, :string
  end
end
