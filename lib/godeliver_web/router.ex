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


    get  "/customers/",         CustomerController, :index
    get  "/customers/new",      CustomerController, :new
    get  "/customers/:id",      CustomerController, :show
    get  "/customers/:id/edit", CustomerController, :edit
    post "/customers",          CustomerController, :create
    put  "/customers/:id",      CustomerController, :update
    get  "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", GodeliverWeb do
  #   pipe_through :api
  # end
end
