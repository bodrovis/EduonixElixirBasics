defmodule Company do
  defstruct title: "", employees: []
  # count/1
  # member?/2
  # reduce/3
  ## enumerable
  ## accumulator (store the result)
  ### { verb, result }
  ### :cont
  ### :halt
  ### :suspend
  ## reducer function to apply

  ## the result: {state, result}
  ### :done
  ### :halted
  ### :suspended

  defimpl Enumerable do
    def reduce(_, {:halt, result}, _fun), do: {:halted, result}

    def reduce(%Company{employees: _employees} = company, {:suspend, result}, fun) do
      {:suspended, result, &reduce(company, &1, fun)}
    end

    def reduce(%Company{employees: []}, {:cont, result}, _fun), do: {:done, result}

    def reduce(%Company{employees: [ head | tail ]}, {:cont, result}, fun) do
      reduce(%Company{employees: tail}, fun.(head, result), fun)
    end

    def count(%Company{employees: employees}) do
      { :ok, Enum.count(employees) }
    end

    def member?(%Company{employees: employees}, employee) do
      { :ok, Enum.member?(employees, employee) }
    end
  end
end

defmodule Employee do
  defstruct name: "", salary: "", works_for: 0

  defimpl String.Chars do
    def to_string(%Employee{name: name, salary: salary}) do
      "Name: #{name}, salary: #{salary}"
    end
  end
end

defmodule Demo do
  def work do
    company = %Company{
      title: "Eduonix",
      employees: [
        %Employee{name: "Ilya", salary: "works for food", works_for: 2},
        %Employee{name: "Boss", salary: "very high", works_for: 100},
        %Employee{name: "Someone else", salary: "who knows", works_for: 9000}
      ]
    }

    Enum.count(company) |> IO.inspect
    Enum.member?(company, %Employee{name: "Ilya", salary: "works for food", works_for: 2}) |>
    IO.inspect

    Enum.reduce(company, 0, fn(employee, total_years) -> employee.works_for + total_years end) |>
    IO.inspect
  end
end

Demo.work()
