defmodule GodeliverWeb.Router do
  use GodeliverWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GodeliverWeb do
    pipe_through :browser # Use the default browser stack


    get  "/users/",         Customer.UserController, :index
    get  "/users/new",      Customer.UserController, :new
    get  "/users/:id",      Customer.UserController, :show
    get  "/users/:id/edit", Customer.UserController, :edit
    post "/users",          Customer.UserController, :create
    put  "/users/:id",      Customer.UserController, :update
    get  "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", GodeliverWeb do
  #   pipe_through :api
  # end
end
