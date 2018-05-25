defmodule Demo do
  def work do
    IO.puts "doing work..."

    result = receive do
      {sender, {a,b}} -> send(sender, a * b)
      #message -> message
    after 5000 -> IO.puts "Enough!"
    end
    IO.puts result
  end

  def run(message) do
    pid = spawn fn ->
      work()
    end

    send pid, {self(), message}

    receive do
      response -> IO.puts("Response: #{response}")
    end
  end
end

#Demo.run("my message")
Demo.run({2,3})
