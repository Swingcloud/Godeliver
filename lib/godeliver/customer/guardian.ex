defmodule Godeliver.Customer.Guardian do
  use Guardian, otp_app: :godeliver

  alias Godeliver.Customer

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(claims) do
    user = claims["sub"]
    |> Customer.get_user!
    {:ok, user}
  end

end
