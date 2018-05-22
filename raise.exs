defmodule Demo do
  defexception message: "error from demo..."
  def run do
    raise Demo, message: "test"
  end
end

Demo.run
