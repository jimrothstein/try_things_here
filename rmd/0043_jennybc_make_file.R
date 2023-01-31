# 043_jennybc_make_file.r
# based on:
# http://stat545.com/automation04_make-activity.html#create-the-makefile




download.file("https://svnweb.freebsd.org/base/head/share/dict/web2?view=co", 
              destfile = "words.txt", 
              quiet = FALSE)

