defmodule Demo do
  def run do
    try do
      Keyword.fetch!([a: 6], :a)
    rescue
      #e in KeyError -> e
      KeyError -> IO.puts("key cannot be found...")
      ArgumentError -> "..."
    after # finally, ensure
      IO.puts "I am executed no matter what!"
    else # executed only if there were no errors
      5 -> "found five!"
      _ -> "not sure what's that..."
    end
  end
end

Demo.run |> IO.inspect
