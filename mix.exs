defmodule BitConverter.MixProject do
  use Mix.Project

  @source_url "https://github.com/FabriDamazio/bitconverter"
  @version "0.1.0"

  def project do
    [
      app: :bit_converter,
      version: @version,
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Hex
      package: package(),
      description: """
      Provides utilities to convert base data types to binary and vice versa.
      """,

      # Docs
      name: "BitConverter",
      docs: [
        main: "BitConverter",
        api_reference: false,
        source_ref: "v#{@version}",
        source_url: @source_url,
        formatters: ["html"],
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      maintainers: ["Fabricio Damazio"],
      licenses: ["MIT"],
      files: ~w(mix.exs README* LICENSE*),
      links: %{
        Website: @source_url,
        GitHub: @source_url
      }
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.34", only: :dev, runtime: false}
    ]
  end
end
