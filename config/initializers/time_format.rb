Time::DATE_FORMATS[:pretty] = lambda { |time| time.strftime("%B %e at %l:%M") + time.strftime("%p").downcase }
Time::DATE_FORMATS[:mdy] = "%B %-d, %Y"
