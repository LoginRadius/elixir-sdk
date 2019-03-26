defmodule LoginradiusElixirSdk.MixProject do
  use Mix.Project

  def project do
    [
      app: :loginradius,
      version: "1.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),

      # Docs
      name: "LoginRadius",
      source_url: "https://github.com/LoginRadius/elixir-sdk",
      homepage_url: "https://www.loginradius.com/",
      docs: [
        main: "LoginRadius",
        logo: "lr-icon.png",
        extras: []
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
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.19.0", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    Elixir wrapper for the LoginRadius API.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["LoginRadius"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/LoginRadius/elixir-sdk"}
    ]
  end
end
