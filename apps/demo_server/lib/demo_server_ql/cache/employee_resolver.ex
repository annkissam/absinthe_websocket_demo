defmodule DemoServerQL.Cache.EmployeeResolver do
  alias DemoServer.{Cache.Employee, Repo}

  import Ecto.Query, warn: false

  def all(_args, _info) do
    {:ok, Repo.all(Employee)}
  end

  def get(%{id: id}, _info) do
    case Repo.get(Employee, id) do
      nil -> {:error, :no_resource_found}
      record -> {:ok, record}
    end
  end

  def get(%{email: email}, _info) do
    query = from e in Employee,
              where: e.email == ^email

    case Repo.one(query) do
      nil -> {:error, :no_resource_found}
      record -> {:ok, record}
    end
  end
end
