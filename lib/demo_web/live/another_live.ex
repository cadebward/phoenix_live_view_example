defmodule DemoWeb.AnotherLive do
  use Phoenix.HTML

  alias DemoWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~E"""
    <div>
      <span>The param is: <%= @param %>
      <div>
        <%= Phoenix.LiveView.live_link("Change Param", to: Routes.live_path(assigns.socket, DemoWeb.ParamLive, :yolo)) %>
      </div>
    </div>
    """
  end
end
