class PagesController < ApplicationController
  def root
  end

  def about
  end

  def flash_check
    flash.now[:gizmo] = "Gizmo donec augue turpis, dictum at lobortis nec, condimentum ac ligula."
    flash.now[:widget] = "Widget quisque at convallis ligula, in dignissim massa. Morbi pharetra, diam non aliquam condimentum."
    flash.now[:dingus] = "Dingus aenean pellentesque sed turpis vitae iaculis. Nam malesuada lorem eu sem tincidunt, id venenatis est pharetra."
  end

  def card_check
  end
end
