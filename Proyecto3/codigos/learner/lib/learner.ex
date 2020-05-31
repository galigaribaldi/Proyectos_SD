defmodule Learner do
  def init(number_of_acceptors) do
    pid = spawn(Learner, :serve, [number_of_acceptors])
    Process.register(pid, :learner_one)
  end
  
  def receive_accept(accept, num) when num == 0 do
    accept
  end
  
  def receive_accept(accept, num) when num > 0 do
    receive do
      {:accept, {id, value}} ->
        IO.inspect(":receive  <#{id}, #{value}>")
         receive_accept([{id, value} | accept], num - 1)
        
    after
      50_000 ->
        accept
    end
    
  end
  
  def serve(acceptors) do
   result = receive_accept([], acceptors)
   if Enum.count(result) >= acceptors / 2 do
    {id, value} = hd(result)
    IO.inspect("Consensus reached: <#{id}, #{value}>")
   else
    IO.inspect("Consensus failed")
    end
  end
end

