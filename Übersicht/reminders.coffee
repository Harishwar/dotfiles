command: "/usr/local/bin/icalBuddy -f uncompletedTasks 2>/dev/null"

refreshFrequency: 600000

style: """
  top: 200px
  left: 30px
  color: #fff
  opacity: 0.8
  font-family: Avenir

  div
    display: block
    font-size: 16px
    padding: 1px
    text-shadow: 0 0 1px rgba(#000, 0.5)

  .header
    font-size: 22px
    font-weight: 10
    text-align: center
    padding-bottom: 6px

"""
render: -> """
  <div class='header'>Reminders</div>
"""

renderLine: (string) -> """
  <div>#{string}</div>
"""

update: (output, domEl) ->
  lines = output.split('\n')
  $(domEl).html '<div class="header">Reminders</div>'
  $(domEl).html '' if output is ""
  for line in lines
   	$(domEl).append @renderLine(line.replace(/^.*(?=•)/,'').replace('[37m','').replace(/[[][3][9][m][ ][()].*/,''))

