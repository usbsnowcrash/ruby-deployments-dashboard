class VersionController < ApplicationController
  def dashboard
    @view_data = DeploymentLogProcedure.new(self, params, session).view_data
  end

  def index
    @view_data = ProjectChangesetsProcedure.new(self, params, session).view_data
  end
end
