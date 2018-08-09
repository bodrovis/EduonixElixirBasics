defprotocol DemoProtocol do
  @fallback_to_any true
  def work(argument)
end

defimpl DemoProtocol, for: Integer do
  def work(argument) do
    argument |> IO.inspect
  end
end

defimpl DemoProtocol, for: Any do
  def work(argument) do
    IO.puts "Some implementation!"
  end
end

defimpl Enumerable, for: Integer do
  def count(_argument) do
    1
  end
end

DemoProtocol.work(42)
DemoProtocol.work([1,2,3])
#Enumerable.count(42) |> IO.puts
