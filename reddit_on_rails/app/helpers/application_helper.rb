module ApplicationHelper
  
  def auth_token 
    html = <<-HTML
      <input type="hidden" name="authenticity_token" value="#{form_authenticity_token}">
    HTML
    html.html_safe
  end 
  
  def errors 
    return "" if flash[:errors].nil? || flash[:errors].empty? 
    html = "<ul>"
    flash[:errors].each do |error|
      html += "<li>#{error}</li>"
    end 
    html += "</ul>"
    html.html_safe
  end 
  
  
  def recurse_comments(comment)
    html = "#{render 'comments/comment', comment: comment}"
    if comment.child_comments.nil?
      return html.html_safe
    else
      html += "<ul class=\"no-list-style\">"
      comment.child_comments.each do |child_comment|
        html += "<li>"
        html += recurse_comments(child_comment)
        html += "</li>"
      end
      html += "</ul>"
      html.html_safe
    end
  end

end
