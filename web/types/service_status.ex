defmodule AscensionApi.Service.Status do
  use Exnumerator,
    values: [:unknown, :offline, :online, :fault]
end