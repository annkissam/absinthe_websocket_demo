defmodule DemoClientWeb.TimesheetController do
  use DemoClientWeb, :controller

  alias DemoClient.Cache
  alias DemoClient.Cache.Timesheet

  def index(conn, _params) do
    timesheets = Cache.list_timesheets()
    render(conn, "index.html", timesheets: timesheets)
  end

  def new(conn, _params) do
    changeset = Cache.change_timesheet(%Timesheet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"timesheet" => timesheet_params}) do
    case Cache.create_timesheet(timesheet_params) do
      {:ok, timesheet} ->
        conn
        |> put_flash(:info, "Timesheet created successfully.")
        |> redirect(to: timesheet_path(conn, :show, timesheet))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    timesheet = Cache.get_timesheet!(id)
    render(conn, "show.html", timesheet: timesheet)
  end

  def edit(conn, %{"id" => id}) do
    timesheet = Cache.get_timesheet!(id)
    changeset = Cache.change_timesheet(timesheet)
    render(conn, "edit.html", timesheet: timesheet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "timesheet" => timesheet_params}) do
    timesheet = Cache.get_timesheet!(id)

    case Cache.update_timesheet(timesheet, timesheet_params) do
      {:ok, timesheet} ->
        conn
        |> put_flash(:info, "Timesheet updated successfully.")
        |> redirect(to: timesheet_path(conn, :show, timesheet))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", timesheet: timesheet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    timesheet = Cache.get_timesheet!(id)
    {:ok, _timesheet} = Cache.delete_timesheet(timesheet)

    conn
    |> put_flash(:info, "Timesheet deleted successfully.")
    |> redirect(to: timesheet_path(conn, :index))
  end
end
