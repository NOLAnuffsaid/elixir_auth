use ExGuard.Config

guard("unit-test", run_on_start: true)
|> command("mix test --color")
# |> watch({~r{lib/(?<dir>.+)/(?<file>.+).ex$}, fn(m) -> "test/#{m["dir"]}/#{m["file"]}_test.exs" end})
|> watch(~r{^lib/.*/.*.(ex|exs)$})
|> watch(~r{^test/.*/.(ex|exs)$})
|> ignore(~r/priv/)
