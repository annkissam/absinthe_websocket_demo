defmodule DemoServerQLApi.Subscription.Employee do
  @moduledoc """
  Subscription adapter module Employee
  """

  @doc false
  def employee_created do
    """
    subscription {
      employee_created {
        id
        name
        email
      }
    }
    """
  end
end
