defmodule Employee do
  defstruct name: "", salary: 0

  defimpl String.Chars do
    def to_string(%Employee{name: name, salary: salary}) do
      "Name: #{name}, salary: #{salary}"
    end
  end
end

defmodule Demo do
  def work do
    %Employee{name: "John", salary: 9000} |> IO.puts
  end
end


IO.puts 5
IO.puts :atom

Demo.work()
