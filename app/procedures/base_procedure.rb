class BaseProcedure
  include Rails.application.routes.url_helpers
  attr_reader :params, :session, :controller

  def initialize(controller, params, session)
    @controller = controller
    @params = params
    @session = session
  end

  def view_data
    fail NotImplementedError.new 'need to implement #view_data'
  end
end
