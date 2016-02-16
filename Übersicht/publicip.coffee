command: "curl -s checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"

refreshFrequency: 3600000

style: """
  bottom: 32px
  left: 10px
  color: #fff
  font-family: Franklin Gothic

  div
    display: block
    text-shadow: 0 0 1px rgba(#000, 0.5)
    font-size: 13px
    font-weight: 100

"""


render: -> """
  <div class='ip_address'></div>
"""

update: (output, domEl) ->
  $(domEl).find('.ip_address').html(output)

