from dotenv import load_dotenv
import os
# Load .env file
load_dotenv()

# Get OpenAI keys from .env file
os.environ["OPENAI_API_KEY"] = os.getenv("OPENAI_API_KEY")

from langchain_community.chat_models import ChatOpenAI
from langchain.output_parsers import ResponseSchema
from langchain.output_parsers import StructuredOutputParser
model = ChatOpenAI(model="gpt-4-turbo-preview", temperature=0)
def analyse_performance(input:str):
    time_complexity_schema=ResponseSchema(
        name="time_complexity",
        description="This is the time complexity of the code"
    )
    space_complexity_schema=ResponseSchema(
        name="space_complexity",
        description="This is the space complexity of the code"
    )
    response_schema=[time_complexity_schema, space_complexity_schema]
    output_parser=StructuredOutputParser.from_response_schemas(response_schema)
    format_instructions=output_parser.get_format_instructions()
  
    from langchain_core.prompts import (
        ChatPromptTemplate,
        # MessagesPlaceholder,
        # HumanMessagePromptTemplate,
        # SystemMessagePromptTemplate,
    )

    

    prompt_template="""
            Tell me the time and space complexity of the code
            {input}.
            {format_instructions}
            """ 

    prompt = ChatPromptTemplate.from_template(template=prompt_template)
    messages=prompt.format_messages(
        input=input,
        format_instructions=format_instructions
    )
    return model.invoke(messages)
# print(generate_code("Write a program for hollow rectangle pattern in c"))


