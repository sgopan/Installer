require 'open-uri'

open('http://www.scala-lang.org/files/archive/scala-2.10.4.tgz') { |f|
	f.each_line{ |line| p line

	}

}

