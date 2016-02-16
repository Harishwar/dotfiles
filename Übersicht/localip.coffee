command: "ifconfig | grep 'inet ' | grep -v 127.0.0.1 | awk '{print $2}'"

refreshFrequency: 360000

style: """
  bottom: 10px
  left: 10px
  color: #fff
  font-family: Franklin Gothic

  div
    display: block
    text-shadow: 0 0 1px rgba(#000, 0.5)
    font-size: 16px
    font-weight: 100

"""


render: -> """
  <div class='ip_address'></div>
"""

update: (output, domEl) ->
  $(domEl).find('.ip_address').html(output)

