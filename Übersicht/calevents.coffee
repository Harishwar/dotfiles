# A widget that displays your calendar events for today and tomorrow
# Made by David Brooks
# First time ever writing in JavaScript
# Using icalBuddy found here: http://hasseg.org/icalBuddy/

# This command shows all of your events for today and tomorrow
command: "/usr/local/bin/icalBuddy -sd -n eventsToday+1 2>/dev/null"

# Uncomment this command if you want to not show which calendar the events are for
#command: "icalBuddy -sd -nc -n eventsToday+1 2>/dev/null"

# the refresh frequency is 1 hour
refreshFrequency: 3600000

style: """
  top: 480px
  left: 30px
  color: #fff
  opacity: 0.75
  font-family: Avenir

  div
    display: block
    text-shadow: 0 0 1px rgba(#000, 0.5)
    font-size: 15px
    font-weight: 500

  label
    font-size: 20px
"""

renderLine: (string) -> """
  <div class='ical'>
    <div class='label'>#{string}</div>
"""

update: (output, domEl) ->
  output = output.charAt(0).toUpperCase() + output.slice(1)
  lines = output.split('\n')
  $(domEl).html ''
  $(domEl).html 'No Events Today or Tomorrow' if output is ""
  for line in lines
  	$(domEl).append @renderLine(line)

