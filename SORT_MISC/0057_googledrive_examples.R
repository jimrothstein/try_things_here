---
TAGS:  gh, googledrive
---
## 057_googledrive_examples.R
library("googledrive")

## configure (one-time	?)
library(gh)
library(usethis)

drive_find(n_max = 25)
drive_find(pattern = "*.mp3")	#1,125 x 3 (voicemails)
?googledrive


drive_find(q = "name contains 'TEST'",
	   q = "modifiedTime > '2017-07-21T12:00:00'")

drive_find(q="createdTime > '2017-06-01T12:00:00'")
## > 7250

drive_find(q="createdTime < '2011-06-01T12:00:00'")
## 71

old<-drive_find(q="createdTime < '2010-06-01T12:00:00'")
## 37

drive_find(q="name = 'hello'")
## 0


drive_find(q="name = 'jim'")
## 1

drive_find(q="fullText contains 'jim'")
## 2358

## retrieve metadata

(x <- drive_get("~/"))
## root info,id= "0AKbttjROtnvNUk9PVA" 


(x <- drive_get(id = "root"))
## same as above

(x <- drive_get(as_id("0AKbttjROtnvNUk9PVA")))
## same as above
