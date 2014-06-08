# -*- coding: utf-8 -*-

require 'fileutils'

LINK_TEXT = "Back to help contents"
# LINK_TEXT = "目次に戻る"

files = ARGV

files.each{|path|
  next if path =~ /help_contents/ 
  html = File.read( path )
  
  html.sub!(/<body>/, <<EOF )

<body>
<p><center><a href="help_contents.html">#{LINK_TEXT}</a></center></p>

EOF

  html.sub!(/<\/body>/, <<EOF )
<p><center><a href="help_contents.html">#{LINK_TEXT}</a></center></p>
</body>
EOF

  # puts html
  open(path , 'w'){|fn| fn.write html }

}

# java がうまく扱ってくれない
# <head>
# <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
# </head>
