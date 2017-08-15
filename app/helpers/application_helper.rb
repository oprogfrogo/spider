module ApplicationHelper
  
  def rating_percent_color(percent)
    case percent
    when 90..100
      output = "<font color='green'>#{number_to_percentage(percent, precision: 2)}</font>"
    when 80..90
      output = "<font color='yellow'>#{number_to_percentage(percent, precision: 2)}</font>"
    when 70..80
      output = "<font color='orange'>#{number_to_percentage(percent, precision: 2)}</font>"
    when 1..70
      output = "<font color='red'>#{number_to_percentage(percent, precision: 2)}</font>"
    when 0
      output = "No rating"
    end
    return output.html_safe
  end
  
end