class Agent < ActiveRecord::Base

  def self.next_agent
    agents = Agent.all
    agents = agents.rotate(agents.index(robin) + 1)

    ready agents.first
    relax agents.last

    return agents.last
  end

  def self.robin
    self.where(round_robin: 1).first || self.first
  end

  def self.ready(agent)
    agent.update_attribute(:round_robin, 1)
  end

  def self.relax(agent)
    agent.update_attribute(:round_robin, 0)
  end

end
