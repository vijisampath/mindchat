defmodule Mindchat.WelcomeTemplate do
@compile if Mix.env == :test, do: :export_all

  @locale_map [%{locale: "default", text: "Welcome"},%{locale: "en_US", text: "Search coin details with bot"}]
  def welcome() do
      message = %{
      "payload" => "welcome",
      }
      IO.inspect(template(message))

      template(message)
  end

  def greeting() do
      Enum.map(@locale_map, &prepare_greeting/1)
      |> template()
  end

  def prepare_greeting(%{locale: loc, text: tex}) do
      %{
      "locale" =>loc,
      "text" => tex,
      }
  end

  defp template(greeting) do
      %{
      "greeting" => greeting,
      }
  end

end
