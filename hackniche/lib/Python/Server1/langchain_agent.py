import os
# replace this with your OpenAI key
from dotenv import load_dotenv
load_dotenv()
os.environ["OPENAI_API_KEY"] = os.getenv("OPENAI_API_KEY")
from embedchain import App
langchain_database = App()
langchain_database.add("https://python.langchain.com/docs/modules/")
langchain_database.add("https://python.langchain.com/docs/modules/model_io/")
langchain_database.add("https://python.langchain.com/docs/modules/agents/")
langchain_database.add("https://python.langchain.com/docs/modules/agents/tools/")
langchain_database.add("https://python.langchain.com/docs/modules/chains")
def langchain_generator(query):   
    return langchain_database.query(query)

# print(langchain_agent("How to create a agent in LangChain?"))