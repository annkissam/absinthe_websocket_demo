defmodule DemoServerQLApi do
  @moduledoc """
  Documentation for DemoServerQLApi.

  DemoServerQLApi.list(:employees)
  DemoServerQLApi.get(:employee, 1)
  DemoServerQLApi.get_by(:employee, %{email: "some.one@some-domain.com"})

  DemoServerQLApi.list!(:employees)
  DemoServerQLApi.get!(:employee, 1)
  DemoServerQLApi.get_by!(:employee, %{email: "some.one@some-domain.com"})

  employee = DemoServer.Cache.get_employee!(1)
  Absinthe.Subscription.publish(DemoServerWeb.Endpoint, employee, employee_created: true)
  """

  use CommonGraphQLClient.Context,
    otp_app: :demo_client

  def subscribe do
    # NOTE: This will call __MODULE__.receive(:employee_created, employee) when data is received
    client().subscribe_to(:employee_created, __MODULE__)

    # (optional) synchronize on reconnect
    # NOTE: This is better in a Task
    list!(:employees)
    |> sync_employees()
  end

  def receive(subscription_name, %{id: id, email: email}) when subscription_name in [:employee_created] do
    import Ecto.Query, warn: false
    alias DemoClient.{Cache.Timesheet, Repo}

    query = from t in Timesheet,
              where: t.employee_email == ^email and is_nil(t.employee_id)

    Repo.all(query)
    |> Enum.each(fn(timesheet) ->
      timesheet
      |> Ecto.Changeset.change(employee_id: id)
      |> Repo.update!()
    end)
  end

  def sync_employees(employees) do
    IO.puts "Beginning Re-connection Sync"

    employees
    |> Enum.each(fn(employee) -> receive(:employee_created, employee) end)

    IO.puts "Completed Re-connection Sync"
  end
end


