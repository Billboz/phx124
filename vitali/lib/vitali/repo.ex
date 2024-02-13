defmodule Vitali.Repo do
  use Ecto.Repo,
    otp_app: :vitali,
    adapter: Ecto.Adapters.Postgres
end
