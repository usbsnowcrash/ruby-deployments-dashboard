require 'spec_helper'
require 'support/mocks/mock_procedure'

describe BaseProcedure do
  let(:procedure) { Mocks::MockProcedure.new(nil, nil, nil) }
  it 'should implement view_data' do
    expect { procedure.view_data }.to raise_error NotImplementedError
  end
end
