
# use datasetjson::
library(datasetjson)


# CDISC requires a ds of this form:
iris_items = tribble(
  
              ~itemOID,         ~name,          ~label, ~dataType, ~length, ~keySequence,
 "IT.IR.Sepal.Length", "Sepal.Length",   "Sepal Length",   "float",     NA,           2,
 "IT.IR.Sepal.Width",  "Sepal.Width",    "Sepal Width",    "float",     NA,          NA,
 "IT.IR.Petal.Length", "Petal.Length", "Petal Length",    "float",     NA,           3,
 "IT.IR.Petal.Width",  "Petal.Width",    "Petal Width",    "float",     NA,          NA,
 "IT.IR.Species",      "Species", "Flower Species",       "string",     10,         1 
 )

iris_items
iris_items |> mutate(ifelse( length == NA), 0, length)

  
# proper CDISC datasetjson requires a format  
ds_json <- dataset_json(head(iris, 5), 
                        item_oid = "IG.IRIS", 
                        name = "IRIS", 
                        dataset_label = "Iris", 
                        columns = iris_items)
ds_json

# start with regular df, start to convert to form cdisc likes, MISSING
tryCatch({
  dataset_json(iris, "IG.IRIS", "IRIS", "Iris", iris_items)
}, error = function(e) {
  print(e)
})

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



