defmodule AscensionApi.Repo do
  use Ecto.Repo, otp_app: :ascension_api
  use Scrivener, page_size: 10
end
