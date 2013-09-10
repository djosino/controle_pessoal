module ApplicationHelper

	
  def flash_message(obj = nil)
    msg = ""
    if flash[:notice].present?
       msg ="<div class='alert info'><span class='icon'></span><strong>Informação:</strong> #{flash[:notice]}</div>"
    elsif flash[:alert].present?
       msg ="<div class='alert warning'><span class='icon'></span><strong>Alerta:</strong> #{flash[:alert]}</div>"
    elsif flash[:error].present?
       msg ="<div class='alert error'><span class='icon'></span><strong>Error:</strong> #{flash[:error]}</div>"
    elsif params[:info_mensagem].present?
       msg ="<div class='alert note'><span class='icon'></span><strong>Nota:</strong> #{params[:info_mensagem]}</div>"
    elsif obj and !obj.errors.blank?
       obj.errors.full_messages.each do |erro|
          msg += "<div class='alert error'><span class='icon'></span><strong>Erros:</strong> #{erro.to_s.gsub('base','')} </div>"
       end
    end
    return ( render :inline => msg )
  end
end
