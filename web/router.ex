defmodule AscensionApi.Router do
  use AscensionApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/api", AscensionApi do
    pipe_through :api

    resources "/services", ServiceController, except: [:new, :edit] do
      resources "/servers", ServerController, only: [:index]
    end

    resources "/servers", ServerController, except: [:new, :edit] do
      resources "/services", ServiceController, only: [:index]
    end

    # Many to Many: Server/Service
    resources "/units", UnitController, only: [:create, :delete]

  end

end
