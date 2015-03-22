class Admin::SettingsController < ApplicationController
  before_action :check_if_admin
  layout 'admin'

  def index
    @total_time       = ConfigTable.find_by_key('total_time').value
    @correct_marks    = ConfigTable.find_by_key('correct_marks').value
    @incorrect_marks  = ConfigTable.find_by_key('incorrect_marks').value
  end

  def update
    total_time       = ConfigTable.find_by_key('total_time')
    correct_marks    = ConfigTable.find_by_key('correct_marks')
    incorrect_marks  = ConfigTable.find_by_key('incorrect_marks')

    total_time.update(value: params[:total_time])
    correct_marks.update(value: params[:correct_marks])
    incorrect_marks.update(value: params[:incorrect_marks])

    @total_time       = total_time.value
    @correct_marks    = correct_marks.value
    @incorrect_marks  = incorrect_marks.value

    render 'index'
  end
end
