

# LSP language server for R  
# nightly build of reditorsupport/lanuageserver
#
install.packages("languageserver", repos = c(
    reditorsupport = "https://reditorsupport.r-universe.dev",
    getOption("repos")
))



#			:LspInfo      to see if LSP see R server (for this buffer/file)

#			what lsp client is attached to buffer?
#			:lua print(vim.inspect(vim.lsp.buf_get_clients()))

