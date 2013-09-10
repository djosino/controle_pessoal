module ApplicationHelper

	
  def flash_message(obj = nil)
    msg = ""
    if flash[:notice].present?
       msg ="<div class='alert alert-success'><a class='close' data-dismiss='alert'>×</a><i class='icon icon-thumbs-up-alt'></i><strong>Informação:</strong> #{flash[:notice]}</div>"
    elsif flash[:alert].present?
       msg ="<div class='alert alert-info'><a class='close' data-dismiss='alert'>×</a><i class='icon icon-thumbs-up-alt'></i><strong>Alerta:</strong> #{flash[:alert]}</div>"
    elsif flash[:error].present?
       msg ="<div class='alert alert-error'><a class='close' data-dismiss='alert'>×</a><i class='icon icon-warning-sign'></i><strong>Error:</strong> #{flash[:error]}</div>"
    elsif params[:info_mensagem].present?
       msg ="<div class='alert alert-info'><a class='close' data-dismiss='alert'>×</a><i class='icon icon-thumbs-up-alt'></i><strong>Nota:</strong> #{params[:info_mensagem]}</div>"
    elsif obj and !obj.errors.blank?
       obj.errors.full_messages.each do |erro|
          msg += "<div class='alert alert-error'><a class='close' data-dismiss='alert'>×</a><i class='icon icon-warning-sign'></i><strong>Erros:</strong> #{erro.to_s.gsub('base','')} </div>"
       end
    end
    return ( render :inline => msg )


    <div class='alert alert-error'><a class='close' data-dismiss='alert'>×</a><i class='icon icon-warning-sign'></i>
    

  end
end
