module ApplicationHelper

	
  def flash_message(obj = nil)
    msg = ""
    if flash[:notice].present?
       msg ="<div class='alert alert-success'><a class='close' data-dismiss='alert'>×</a><i class='icon icon-thumbs-up-alt'></i><strong> Informação:</strong> #{flash[:notice]}</div>"
    elsif flash[:alert].present?
       msg ="<div class='alert alert-info'><a class='close' data-dismiss='alert'>×</a><i class='icon icon-thumbs-up-alt'></i><strong> Alerta:</strong> #{flash[:alert]}</div>"
    elsif flash[:error].present?
       msg ="<div class='alert alert-error'><a class='close' data-dismiss='alert'>×</a><i class='icon icon-warning-sign'></i><strong> Error:</strong> #{flash[:error]}</div>"
    elsif params[:info_mensagem].present?
       msg ="<div class='alert alert-info'><a class='close' data-dismiss='alert'>×</a><i class='icon icon-thumbs-up-alt'></i><strong> Nota:</strong> #{params[:info_mensagem]}</div>"
    elsif obj and !obj.errors.blank?
       obj.errors.full_messages.each do |erro|
          msg += "<div class='alert alert-error'><a class='close' data-dismiss='alert'>×</a><i class='icon icon-warning-sign'></i><strong> Erros:</strong> #{erro.to_s.gsub('base','')} </div>"
       end
    end
    return ( render :inline => msg )
  end

  def observe_field(object, url, with, update)
    retorno = "<script>"
    retorno += "jQuery('#{object}').bind('change', function(){"
    retorno += "jQuery.ajax({
                  url: '#{url}',
                  type: 'POST',
                  data: {'#{with}' : jQuery('#{object}').val()},
                  dataType: 'html',
                  success: function(data) {
                    jQuery('#{update}').html(data);
                  }
                });
              });"
    retorno += "</script>"
    return retorno.html_safe
  end
  
   def meses
      [['Janeiro',1], ['Fevereiro',2], ['Março',3], ['Abril',4], ['Maio',5], ['Junho',6], ['Julho',7], ['Agosto',8], ['Setembro',9], ['Outubro',10], ['Novembro',11], ['Dezembro',12]]
   end

   def anos
      anos = []
      for i in 2013..Date.today.year
         anos << i
      end
      return anos
   end 

   def edit_icon
     return image_tag('<i class="icon-calendar"></i>',:title => 'Editar')
   end

   def show_icon
     return image_tag('/assets/images/template/icons/packs/fugue/16x16/shadeless/finder.png',:title => 'Visualizar')
   end

   def delete_icon
     return image_tag('/assets/images/template/icons/packs/fugue/16x16/shadeless/cross.png',:title => 'Remover')
   end

   def config_icon
     return image_tag('/assets/images/template/icons/packs/fugue/16x16/shadeless/document-pdf-text.png',:title => 'PDF Text')
   end

   def yes_or_no?(value)
      value ? "Sim" : "Nao"
   end

   def true_or_nil?(value)
      value ? true : nil
   end
end
