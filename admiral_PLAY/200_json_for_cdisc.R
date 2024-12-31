

# use datasetjson::
library(datasetjson)
?datasetjson

attributes(iris)

# start with regular df, start to convert to form cdisc likes
ds_json <- dataset_json(iris[1:5, ], "IG.IRIS", "IRIS", "Iris", iris_items)
attributes(ds_json)
ds_json |> class()


ds_updated <- ds_json |>
  set_data_type("referenceData") |>
  set_file_oid("/some/path") |>
  set_metadata_ref("some/define.xml") |>
  set_metadata_version("MDV.MSGv2.0.SDTMIG.3.3.SDTM.1.7") |>
  set_originator("Some Org") |>
  set_source_system("source system", "1.0") |>
  set_study_oid("SOMESTUDY")



ds_updated <- ds_json |>
  datasetjson::set_data_type("referenceData")
