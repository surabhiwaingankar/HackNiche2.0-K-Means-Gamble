from dotenv import load_dotenv
import os
# Load .env file
load_dotenv()

# Get OpenAI keys from .env file
os.environ["OPENAI_API_KEY"] = os.getenv("OPENAI_API_KEY")

from langchain_community.chat_models import ChatOpenAI
from langchain.output_parsers import ResponseSchema
from langchain.output_parsers import StructuredOutputParser

from langchain_core.prompts import (
    ChatPromptTemplate,
    MessagesPlaceholder,
    HumanMessagePromptTemplate,
    SystemMessagePromptTemplate,
)

model = ChatOpenAI(model="gpt-4-turbo-preview", temperature=0)
def analyse_code(input:str):
    code_smell_schema=ResponseSchema(
        name="code_smell",
        description="This is the code smell count. Should be a double value"
    )
    code_duplication_schema=ResponseSchema(
        name="code_duplication",
        description="This is the code duplication fraction count. Should be a double value"
    )
    bug_detection_schema=ResponseSchema(
        name="bug_detection",
        description="This is the bug detection count.Should be a double value."
    )
    defects_schema=ResponseSchema(
        name="defects",
        description="This is the defects count.Should be a double value."
    )
    time_complexity_schema=ResponseSchema(
        name="time_complexity",
        description="This is the time  complexity of the code"
    )
    space_complexity_schema=ResponseSchema(
        name="space_complexity",
        description="This is the  space complexity of the code"
    )
    ways_to_improve_schema=ResponseSchema(
        name="ways to improve",
        description="these are the ways through which u can improve the code."
    )
    response_schema=[code_smell_schema,code_duplication_schema,bug_detection_schema,defects_schema,time_complexity_schema,space_complexity_schema, ways_to_improve_schema]
    output_parser=StructuredOutputParser.from_response_schemas(response_schema)
    format_instructions=output_parser.get_format_instructions()
    # system_template="""
    #           You are a tool used for code analysis. Your job is to analyze the code provided to you.
    #           On every code provided to you , you have to perform  the following analysis:
    #           Syntax and Style Check:
    #           Code Smells Count : 
    #            Code Duplication Percentage:
    #            Bug Detection :
    #            No of defects :
    #         Do not explain the code . Just provide the analysis and provide numeric count for each of the code above.
    #         """ 
    prompt_template = """
    Analysis of the code provided on the following basis:
    Everything is to be provided in numeric count.
            Syntax and Style Check: 
            Code Smells Count : 
            Code Duplication Percentage:
            Bug Detection :
            No of defects :
    {input}
    {format_instructions}
    """

    prompt = ChatPromptTemplate.from_template(template=prompt_template)
    messages=prompt.format_messages(
            input=input,
            format_instructions=format_instructions
        )
    return model.invoke(messages)