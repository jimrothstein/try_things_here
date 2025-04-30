pak::pak("ellmer")
pak::pak("ollamar")


library(ellmer)
library(ollamar)

chat = chat_gemini(api_key=Sys.getenv("GOOGLE_API_KEY"))
chat$chat("Who is the US President?")



ollamar::pull("llama3.2")
chat <- chat_ollama(model = "llama3.2")

chat$chat("Tell me three jokes about statisticians")
chat$chat("Describe Reimann hypothosis")
chat$chat("What models does Ollama support?")


ollamar::test_connection()
ollamar::list_models()
