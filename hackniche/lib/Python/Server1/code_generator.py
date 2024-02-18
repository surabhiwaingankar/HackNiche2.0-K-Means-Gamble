from dotenv import load_dotenv
import os
# Load .env file
load_dotenv()
from bs4 import BeautifulSoup
import requests
# Get OpenAI keys from .env file
os.environ["OPENAI_API_KEY"] = os.getenv("OPENAI_API_KEY")

from langchain_community.chat_models import ChatOpenAI
from langchain.output_parsers import ResponseSchema
from langchain.output_parsers import StructuredOutputParser
model = ChatOpenAI(model="gpt-4-turbo-preview", temperature=0)

def generate_code(input:str):
    code_schema=ResponseSchema(
        name="code",
        description="This is the generated code"
    )
    explaination_schema=ResponseSchema(
        name="explaination",
        description="This is the explaination of the code"
    )
    response_schema=[code_schema,explaination_schema]
    output_parser=StructuredOutputParser.from_response_schemas(response_schema)
    format_instructions=output_parser.get_format_instructions()
  
    from langchain_core.prompts import (
        ChatPromptTemplate,
        # MessagesPlaceholder,
        # HumanMessagePromptTemplate,
        # SystemMessagePromptTemplate,
    )

    

    prompt_template="""
            Generate a program for the following query in the users style.
            
            the user code style is: 
            
            
            Consider the schema provided by users:
            
            {input}
            {format_instructions}
            """ 

    prompt = ChatPromptTemplate.from_template(template=prompt_template)
    messages=prompt.format_messages(
        input=input,
        format_instructions=format_instructions
    )
    return model.invoke(messages)
print(generate_code("Write a program for hollow rectangle pattern in c"))

def scrape_github(url):
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')

    # Extract data from the parsed HTML
    # For example, to get the content of a specific file:
    file_content = soup.find('text_area').text

    return file_content

# print(scrape_github('https://github.com/surabhiwaingankar/Natours/blob/main/controllers/authenticationController.js'))