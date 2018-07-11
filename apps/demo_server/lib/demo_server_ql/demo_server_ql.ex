defmodule DemoServerQL.Schema do
  use Absinthe.Schema
  import_types DemoServerQL.Schema.Types

  query do
    field :employees, list_of(:employee) do
      resolve &DemoServerQL.Cache.EmployeeResolver.all/2
    end

    field :employee, :employee do
      arg :id, :id
      arg :email, :string

      resolve &DemoServerQL.Cache.EmployeeResolver.get/2
    end
  end
end
