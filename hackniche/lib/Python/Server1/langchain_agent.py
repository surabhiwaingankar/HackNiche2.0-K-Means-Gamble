from langchain_community.chat_models import ChatOpenAI
from dotenv import load_dotenv
load_dotenv()
from langchain.chains import LLMRequestsChain,LLMChain



 
def scraping_doxumentation(query:str):
    
    scarping_llm=ChatOpenAI(model_name="gpt-4-turbo-preview")
    template="""
    Extract the documentation of langchain for the following query :
    {query}
    """
    prompt = ChatPromptTemplate.from_template(template=template)
    messages=prompt.format_messages(
        input=query,
        
    )
    chain=LLMRequestsChain(llm_chain=LLMChain(llm=scarping_llm,prompt=messages))
    inputs={
        "query":query,
        "url":f"https://python.langchain.com/docs/get_started/introduction+"+query.replace(" ","+")   
    }
    documentation=chain.run(inputs)
    return documentation
documentation=scraping_doxumentation("Create a chain in langchain")