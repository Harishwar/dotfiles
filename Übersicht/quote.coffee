command: 'curl -s "http://feeds.feedburner.com/brainyquote/QUOTEBR"'

refreshFrequency: 30000

style: """
  bottom: 50px
  right: 10px
  color: #fff
  font-family: Avenir

  .output
    padding: 5px 10px
    width: auto
    max-width: 1000px
    font-size: 16px
    font-weight: lighter
	  font-smoothing: antialiased

  .author, .example, .example-meaning
    text-transform: capitalize
    font-size: 14px
  .author
    text-align: right
"""

render: (output) -> """
  <div class="output">
  <div>
    <text class="quote"></text>
    &emsp;-
    <text class="author"></text>
  </div>

  </div>
"""

update: (output, domEl) ->
  # Define constants, and extract the juicy html.
  dom = $(domEl)
  xml = jQuery.parseXML(output)
  $xml = $(xml)
  description = jQuery.parseHTML($xml.find('description').eq(1).text())
  $description = $(description)

 # Find the info we need, and inject it into the DOM.
  dom.find('.quote').html $xml.find('description').eq(2)
  dom.find('.author').html $xml.find('title').eq(2)


