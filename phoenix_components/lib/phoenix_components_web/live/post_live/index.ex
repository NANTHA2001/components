defmodule PhoenixComponentsWeb.PostLive.Index do
  use PhoenixComponentsWeb, :live_view

  alias PhoenixComponents.Timeline
  alias PhoenixComponents.Timeline.Post

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Timeline.subscribe()

    {:ok, stream(socket, :posts, Timeline.list_posts(), temporary_assigns: [posts: []])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Post")
    |> assign(:post, Timeline.get_post!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Post")
    |> assign(:post, %Post{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Posts")
    |> assign(:post, nil)
  end

  @impl true
  def handle_info({PhoenixComponentsWeb.PostLive.FormComponent, {:saved, post}}, socket) do
    {:noreply, stream_insert(socket, :posts, post)}
  end



  @impl true
  def handle_info({:post_created, post}, socket) do
    {:noreply, update(socket, :posts, fn post -> [post |post] end)}
  end

  @impl true
  def handle_info({:post_updated, post}, socket) do
    {:noreply, update(socket, :posts, fn post -> [post |post] end)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Timeline.get_post!(id)

    IO.puts("Deleting post with ID: #{id}")

    {:ok, _} = Timeline.delete_post(post)

    {:noreply,
    socket
    |> put_flash(:info, "Post deleted successfully")
    |> push_navigate(to: ~p"/posts")}
  end
end
