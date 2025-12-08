defmodule HexMovesWeb.PageController do
  use HexMovesWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
