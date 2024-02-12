defmodule PhoenixComponents.TimelineFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixComponents.Timeline` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        likes_counts: 42,
        reposts_count: 42,
        username: "some username"
      })
      |> PhoenixComponents.Timeline.create_post()

    post
  end
end
