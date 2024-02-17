from langchain_community.llms import OpenAI
from langchain_community.chat_models import ChatOpenAI
from langchain.chains.conversation.memory import ConversationBufferWindowMemory
from dotenv import load_dotenv
from langchain.agents import Tool
from langchain.prompts import PromptTemplate
from langchain.agents import load_tools
from langchain.agents import initialize_agent
from langchain.chains import LLMRequestsChain,LLMChain


load_dotenv()

def scraping_documentation(query:str):

    scarping_llm=ChatOpenAI(model_name="gpt-4-turbo-preview")
    template="""
    Extract the documentation of langchain for the following query :
    {query}
    """
    prompt =PromptTemplate(
    input_variables=["query"],
    template=template,
    )
    chain=LLMRequestsChain(llm_chain=LLMChain(llm=scarping_llm,prompt=prompt))
    inputs={
        "query":query,
        "url":f"https://python.langchain.com/docs/get_started/introduction+"+query.replace(" ","+")   
    }
    documentation=chain.run(inputs)
    return documentation