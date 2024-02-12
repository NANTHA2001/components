defmodule PhoenixComponentsWeb.Mycomponent do
  use Phoenix.Component

 attr :title, :string, required: true

 def heading(assigns) do
   ~H"""
   <h1 class="text-2xl"><%= @title %></h1>
   """
 end



 attr :name, :string, default: "Nantha"
 # attr :email, :string, default: "nanthakumarg2001@gmail.com"

  def greet(assigns) do
   ~H"""
   Hi <%= @name %> <%= self() |> :erlang.pid_to_list() %>
   """
  end


 attr :message, :string, default: "nanthakumarg2001@gmail.com"
 attr :rest, :global, default: %{class: "bg-blue-200"}

   def notification(assigns) do
     ~H"""
     <span {@rest}><%= @message %></span>
     """
   end


   slot :inner_block, required: true

   attr :entries, :list, default: []

   def unordered_list(assigns) do
     ~H"""
     <ul>
       <%= for entry <- @entries do %>
         <li><%= render_slot(@inner_block, entry) %></li>
       <% end %>
     </ul>
     """
   end


   slot :header
slot :inner_block, required: true
slot :footer, required: true

def modal(assigns) do
  ~H"""
  <div class="modal">
    <div class="modal-header">
      <%= render_slot(@header) || "Modal" %>
    </div>
    <div class="modal-body">
      <%= render_slot(@inner_block) %>
    </div>
    <div class="modal-footer">
      <%= render_slot(@footer) %>
    </div>
  </div>
  """
end
end
