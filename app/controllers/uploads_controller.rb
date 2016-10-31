# frozen_string_literal: true
class UploadsController < ApplicationController
  def create
    attachment = Attachment.create!(file: params[:file])
    render json: { url: attachment.file.url(:preview), id: attachment.id }
  end

  def destroy
    attachment = Attachment.find params[:id]
    attachment.destroy
    render nothing: true
  end
end
