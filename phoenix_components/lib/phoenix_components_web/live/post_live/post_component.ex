defmodule PhoenixComponentsWeb.PostLive.PostComponent do
  use PhoenixComponentsWeb, :live_component

  def render(assigns) do
    ~H"""
    <div id={"post-" <> Integer.to_string(@post.id)} class="post bg-black-100 border-solid border border-gray-300 rounded-lg p-4 mb-4 mt-2">
      <div class="flex items-center mb-2">
        <div class="w-10 h-10 bg-gray-300 rounded-full mr-4"></div>
        <div class="flex-1">
          <div class="text-sm font-medium text-gray-800"><%= @post.username %></div>
          <div class="text-xs text-gray-600">Just now</div>
        </div>
      </div>


      <div class="text-base text-gray-700 mb-2">
        <%= @post.body %>
      </div>


      <div class="flex  justify-between">

        <div class="flex items-center mr-4">
        <a href="#" phx-click="like" phx-target={@myself}>
          <img src="/images/heart.svg"/>
          <span class="ml-1 text-sm text-gray-800"><%= @post.likes_counts %></span>
          </a>
        </div>

        <div class="flex items-center">
        <a href="#" phx-click="repost" phx-target={@myself} >
          <img src="/images/repeat-2.svg"/>
          <span class="ml-1 text-sm text-gray-800"><%= @post.reposts_count %></span>
          </a>
        </div>

        <div class="flex items-center  gap-3">
          <.link navigate={~p"/posts/#{@post.id}/edit"}>
          <img src="/images/pencil.svg"/>
          </.link>
          <.link
            phx-click="delete"
            phx-value-id={@post.id}
          >
          <img src="/images/trash-2.svg"/>
          </.link>
        </div>

      </div>
    </div>
    """
  end
  def handle_event("like", _, socket) do
    PhoenixComponents.Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end

  def handle_event("repost", _, socket) do
    PhoenixComponents.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end
end
