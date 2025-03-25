install.packages("ellmer")

library(ellmer)
chat = chat_gemini(api_key=Sys.getenv("GOOGLE_API_KEY"))
chat$chat("Who is the US President?")

