defmodule DemoServerQLApi.Client do
  use CommonGraphQLClient.Client,
    otp_app: :demo_client,
    mod: DemoServerQLApi

  defp handle(:list, :employees) do
    do_post(
      :employees,
      DemoServerQLApi.Schema.Employee,
      DemoServerQLApi.Query.Employee.list()
    )
  end

  defp handle(:get, :employee, id), do: handle(:get_by, :employee, %{id: id})

  defp handle(:get_by, :employee, variables) do
    do_post(
      :employee,
      DemoServerQLApi.Schema.Employee,
      DemoServerQLApi.Query.Employee.get_by(variables),
      variables
    )
  end
end

