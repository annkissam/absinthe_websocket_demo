defmodule DemoServerQLApi do
  @moduledoc """
  Documentation for DemoServerQLApi.

  DemoServerQLApi.list(:employees)
  DemoServerQLApi.get(:employee, 1)
  DemoServerQLApi.get_by(:employee, %{email: "some.one@some-domain.com"})

  DemoServerQLApi.list!(:employees)
  DemoServerQLApi.get!(:employee, 1)
  DemoServerQLApi.get_by!(:employee, %{email: "some.one@some-domain.com"})
  """

  use CommonGraphQLClient.Context,
    otp_app: :demo_client
end
