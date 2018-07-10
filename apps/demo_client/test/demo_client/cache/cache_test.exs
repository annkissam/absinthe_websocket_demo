defmodule DemoClient.CacheTest do
  use DemoClient.DataCase

  alias DemoClient.Cache

  describe "timesheets" do
    alias DemoClient.Cache.Timesheet

    @valid_attrs %{employee_email: "some employee_email", employee_id: 42, notes: "some notes"}
    @update_attrs %{employee_email: "some updated employee_email", employee_id: 43, notes: "some updated notes"}
    @invalid_attrs %{employee_email: nil, employee_id: nil, notes: nil}

    def timesheet_fixture(attrs \\ %{}) do
      {:ok, timesheet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cache.create_timesheet()

      timesheet
    end

    test "list_timesheets/0 returns all timesheets" do
      timesheet = timesheet_fixture()
      assert Cache.list_timesheets() == [timesheet]
    end

    test "get_timesheet!/1 returns the timesheet with given id" do
      timesheet = timesheet_fixture()
      assert Cache.get_timesheet!(timesheet.id) == timesheet
    end

    test "create_timesheet/1 with valid data creates a timesheet" do
      assert {:ok, %Timesheet{} = timesheet} = Cache.create_timesheet(@valid_attrs)
      assert timesheet.employee_email == "some employee_email"
      assert timesheet.employee_id == 42
      assert timesheet.notes == "some notes"
    end

    test "create_timesheet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cache.create_timesheet(@invalid_attrs)
    end

    test "update_timesheet/2 with valid data updates the timesheet" do
      timesheet = timesheet_fixture()
      assert {:ok, timesheet} = Cache.update_timesheet(timesheet, @update_attrs)
      assert %Timesheet{} = timesheet
      assert timesheet.employee_email == "some updated employee_email"
      assert timesheet.employee_id == 43
      assert timesheet.notes == "some updated notes"
    end

    test "update_timesheet/2 with invalid data returns error changeset" do
      timesheet = timesheet_fixture()
      assert {:error, %Ecto.Changeset{}} = Cache.update_timesheet(timesheet, @invalid_attrs)
      assert timesheet == Cache.get_timesheet!(timesheet.id)
    end

    test "delete_timesheet/1 deletes the timesheet" do
      timesheet = timesheet_fixture()
      assert {:ok, %Timesheet{}} = Cache.delete_timesheet(timesheet)
      assert_raise Ecto.NoResultsError, fn -> Cache.get_timesheet!(timesheet.id) end
    end

    test "change_timesheet/1 returns a timesheet changeset" do
      timesheet = timesheet_fixture()
      assert %Ecto.Changeset{} = Cache.change_timesheet(timesheet)
    end
  end
end
