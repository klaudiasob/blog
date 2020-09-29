require 'rails_helper'

RSpec.describe Ability, :type => :model do

  ability.should be_able_to(:manage, House.new(owner: owner))
  ability.should_not be_able_to(:manage, House.new)
end
