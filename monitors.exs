defmodule MyDemo do
  def work do
    IO.puts "doing work..."
    exit :error
  end

  def run do
    #pid = spawn fn -> work() end
    #Process.monitor pid
    spawn_monitor(MyDemo, :work, [])

    receive do
      msg -> IO.inspect msg
    end
  end
end

MyDemo.run
