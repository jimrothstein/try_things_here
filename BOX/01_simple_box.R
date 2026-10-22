box::use(
  tibble,
  mod/hello
)
hello$hello("jim")

options('box.path')

day = date()
log = function (msg) {
  box::use(glue[glue])
  # We can now use `glue` inside the function:
  message(glue('{day}-[LOG MESSAGE] {msg}'))
}

log('test')
