from dotenv import load_dotenv
import os
# Load .env file
load_dotenv()

# Get OpenAI keys from .env file
os.environ["OPENAI_API_KEY"] = os.getenv("OPENAI_API_KEY")

from langchain_community.chat_models import ChatOpenAI
from langchain.agents import create_openai_tools_agent
from langchain.output_parsers import ResponseSchema
from langchain.output_parsers import StructuredOutputParser

from langchain_core.prompts import (
    ChatPromptTemplate,
    MessagesPlaceholder,
    HumanMessagePromptTemplate,
    SystemMessagePromptTemplate,
)

model = ChatOpenAI(model="gpt-4-turbo-preview", temperature=0)
code_smell_schema=ResponseSchema(
    name="code_smell",
    description="This is the code smell count"
)
code_duplication_schema=ResponseSchema(
    name="code_duplication",
    description="This is the code duplication percentage"
)
bug_detection_schema=ResponseSchema(
    name="bug_detection",
    description="This is the bug detection count"
)
defects_schema=ResponseSchema(
    name="defects",
    description="This is the defects count"
)
response_schema=[code_smell_schema,code_duplication_schema,bug_detection_schema,defects_schema]
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
        input="""
            def calculate_average(numbers):
    total = 0
    count = 0

    for num in numbers:
        total = total + num
        count += 1

    average = total / count

    return average

# Example usage
numbers = [10, 20, 30, 40]
result = calculate_average(numbers)
print("The average is: " + result)

        """,
        format_instructions=format_instructions
    )
model.invoke(messages)