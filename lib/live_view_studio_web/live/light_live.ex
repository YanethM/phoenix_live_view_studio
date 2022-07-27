defmodule LiveViewStudioWeb.LightLive do
  use LiveViewStudioWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :brightness, 10)}
  end

  def render(assigns) do
    ~L"""
    
    <h1>Front Porch Light</h1>
    <div class="meter">
      <span style="width:0% <%= @brightness %>%">
        <%= @brightness %>%
      </span>
    </div>
      <button phx-click="off">
        <img src="/images/turned-off-light.svg">
        <span class="sr-only">Off</span>
     </button>
    <button phx-click="down">
    <span class="sr-only">Down</span>
    </button>
    
    <button phx-click="up">
    <span class="sr-only">Up</span>
    </button>
    <button phx-click="on">
    <img src="/images/turned-off-light.svg">
    <span class="sr-only">On</span>
    </button>
    
    """
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brightness, &max(&1 - 10, 0))
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    socket = update(socket, :brightness, &min(&1 + 10, 100))
    {:noreply, socket}
  end
end
