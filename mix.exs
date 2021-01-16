defmodule Etna.MixProject do
  use Mix.Project

  @description """
  Etna is a utility library inspired by RubyGem's ActiveSupport.
  It provides a convenient function protocol often used in Rails.
  """

  def project do
    [
      app: :etna,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: @description,
      package: [
        maintainers: ["gr8distance"],
        licenses: ["MIT"],
        links: %{ Github: "https://github.com/gr8distance/etna" }
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
