fun main {} : transaction page = 
  return
    <xml>
      <head>

        (* activeHead should work like the following, but it doesn't *)
        (* <script> *)
        (*   alert('aaaaa'); *)
        (* </script> *)

        <activeHead code={alert "bbbbb"}/>

      </head>
      <body>
      </body>
    </xml>
