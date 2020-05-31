defmodule Acceptor do
  def init(number) do
    pid = spawn(Acceptor, :serve, [[{:learner_one, :"learner_one@192.168.0.14"}], {0, nil}])
    case number do
      1 -> Process.register(pid, :acceptor_one)
      2 -> Process.register(pid, :acceptor_two)
      3 -> Process.register(pid, :acceptor_three)
    end
  end
  def serve(learners, {max_id, accepted_value}) do
    receive do
      {:prepare, id, proposer} ->
        IO.puts("Receive a prepare <#{id}>")
        max_id =
          if id > max_id do
            IO.inspect("Send a promise <#{id}>, #{accepted_value}>")
            send(proposer, {:promise, {id, accepted_value}})
            id
          else
            max_id
          end

        serve(learners, {max_id, accepted_value})

      {:propose, id, value, proposer} ->
        IO.inspect("Receive a propose <#{id}, #{value}>")
        if id == max_id do
          IO.inspect("Send a accept <#{id}, #{value}>")
          send(proposer, {:accept, {id, value}})
          learners
          |> Enum.each(&Process.send(&1, {:accept, {id, value}},[]))
          serve(learners, {id, value})
        else
          serve(learners, {id, accepted_value})
        end
    after
      90_000 ->
        if not is_nil(accepted_value) do
	IO.inspect("Consensus reached: <#{max_id}, #{accepted_value}>")
	else
	IO.inspect("Server timeout")
	end
    end
  end
end

