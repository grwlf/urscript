fun js {} : transaction xhead =
  return (Script.insert (blessMime "text/javascript") (bless "http://code.jquery.com/ui/1.10.3/jquery-ui.js"))
  

fun main {} : transaction page = 
  s <- js {};
  return
    <xml>
      <head>
        {s}
        <script type={blessMime "text/javascript"} src={bless "http://code.jquery.com/ui/1.10.3/jquery-ui.js"}/>
      </head>
      <body>
      </body>
    </xml>
