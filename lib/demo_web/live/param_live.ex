defmodule DemoWeb.ParamLive do
  use Phoenix.LiveView

  alias DemoWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~L"""
    <%= DemoWeb.AnotherLive.render(assigns) %>
    """
  end

  def handle_params(%{"param" => param}, _uri, socket) do
    {:noreply, assign(socket, param: param)}
  end

  def mount(_session, socket) do
    {:ok, assign(socket, param: "NOTHING")}
  end
end

