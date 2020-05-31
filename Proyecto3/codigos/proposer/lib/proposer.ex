defmodule Proposer do
  def receive_request() do
    receive do
      {:request, value} ->
        value
    end
  end
  
  def receive_promises(promises, num) when num == 0 do
    promises
  end

  def receive_promises(promises, num) do
    receive do
      {:promise, promise} ->
        receive_promises([promise | promises], num - 1)
    after
      # wait for 10s
      10_000 ->
        promises
    end
  end
  
  def receive_accept(accepted, num) when num == 0 do
    accepted
  end
  
  def receive_accept(accepted, num) do
    receive do
      {:accept, accept} ->
        receive_accept([accept | accepted], num - 1)
    after
      # wait for 3s
      10_000 ->
        accepted
    end
  end

  def serve(acceptors) do
    value = receive_request()
    propose(acceptors, {1, value})
  end

  def propose(acceptors, {id, value}) do
    new_id = id + 1
    IO.inspect("Prepare: <#{id}>")
    acceptors
    |>Enum.each(fn a ->
      Process.sleep(2_000)
      Process.send(a, {:prepare, id, self()}, [])
    end)

    promises = receive_promises([], Enum.count(acceptors))
    if Enum.count(promises) <= Enum.count(acceptors) / 2 do
      propose(acceptors, {new_id, value})
    end

    value =
      Enum.reduce_while(
        promises,
        value,
        fn {_id, value}, acc ->
          if value == acc or is_nil(value), do: {:cont, acc}, else: {:halt, acc}
        end
      )
   
   IO.inspect("Propose: <#{id}, #{value}>")
    Enum.each(acceptors, fn a -> 
      Process.sleep(2_000)
      send(a, {:propose, id, value, self()}) 
    end)

    accept_messages = receive_accept([], Enum.count(acceptors))

    if Enum.count(accept_messages) <= Enum.count(acceptors) / 2 do
      propose(acceptors, {new_id, value})
    end

    IO.inspect("There's consensus, accepted value: #{value}")
  end
end

