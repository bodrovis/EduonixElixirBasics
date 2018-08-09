defmodule Demo do
  def work do
    :timer.sleep 2000
    42
  end
end

worker = Task.async(fn -> Demo.work end)
IO.puts "We can still  do something else..."

answer = Task.await worker
IO.puts "The answer is #{answer}"
