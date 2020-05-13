class PagesController < ApplicationController
  before_action :authenticate_user!, only: :secret

  def root
  end

  def about
  end

  def secret
    # only signed in users should see this page
  end
end
