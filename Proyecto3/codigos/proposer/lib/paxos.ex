defmodule Paxos do
  def config() do
    Node.connect(:"acceptor_one@192.168.0.11")
    Node.connect(:"acceptor_two@192.168.0.12")
    Node.connect(:"acceptor_three@192.168.0.13")
    Node.connect(:"learner_one@192.168.0.14")

  end

  def run(value) do
    acceptors = 
    [{:acceptor_one, :"acceptor_one@192.168.0.11"}, 
    {:acceptor_two, :"acceptor_two@192.168.0.12"}, 
    {:acceptor_three, :"acceptor_three@192.168.0.13"}]
    
    pid = spawn(Proposer, :serve, [acceptors])
    send(pid, {:request, value})
  end

  #iex --sname acceptor_three --cookie '123' -S mix
end
