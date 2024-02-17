from dotenv import load_dotenv
import os
import json
import re
# Load .env file
load_dotenv()

# Get OpenAI keys from .env file
os.environ["OPENAI_API_KEY"] = os.getenv("OPENAI_API_KEY")

from langchain_community.chat_models import ChatOpenAI
from langchain.output_parsers import ResponseSchema
from langchain.output_parsers import StructuredOutputParser
from langchain_core.output_parsers import JsonOutputParser
from langchain_core.pydantic_v1 import BaseModel, Field

class Code(BaseModel):
    code:str=Field(description="This is the generated code")
    explaination:str=Field(description="This is the explaination of the code")

model = ChatOpenAI(model="gpt-4-turbo-preview", temperature=0)

def generate_code(input:str):
    # code_schema=ResponseSchema(
    #     name="code",
    #     description="This is the generated code"
    # )
    # explaination_schema=ResponseSchema(
    #     name="explaination",
    #     description="This is the explaination of the code"
    # )
    # response_schema=[code_schema,explaination_schema]
    parser = JsonOutputParser(pydantic_object=Code)
    format_instructions=parser.get_format_instructions()
  
    from langchain_core.prompts import (
        ChatPromptTemplate,
        # MessagesPlaceholder,
        # HumanMessagePromptTemplate,
        # SystemMessagePromptTemplate,
    )

    

    prompt_template="""
            Generate a program for the given input.Explain the code generated.
            {input}.
            {format_instructions}
            """ 

    prompt = ChatPromptTemplate.from_template(template=prompt_template)
    messages=prompt.format_messages(
        input=input,
        format_instructions=format_instructions
    )
    return model.invoke(messages)


def convert_ai_message_to_json(message):
    # Extract JSON-like string from the message
    match = re.search(r'json\n({.*?})', message, re.DOTALL | re.MULTILINE)
    if match:
        json_like_str = match.group(1)
        
        # Parse the JSON-like string into a Python dictionary
        dict_obj = json.loads(json_like_str)
        
        # Convert the Python dictionary back to a JSON string
        json_str = json.dumps(dict_obj)
        
        return json_str
    else:
        return None
    
# print(convert_ai_message_to_json(""""
# 'Given the requirements and the output schema, here is the generated program for creating a hollow rectangle pattern in C, along with an explanation of the code. The output is formatted as a JSON instance that conforms to the provided JSON schema.\n\njson\n{\n "code": "#include <stdio.h>\\n\\nvoid printHollowRectangle(int rows, int columns) {\\n for (int i = 1; i <= rows; i++) {\\n for (int j = 1; j <= columns; j++) {\\n if (i == 1 || i == rows || j == 1 || j == columns) {\\n printf(\\"*\\");\\n } else {\\n printf(\\" \\");\\n }\\n }\\n printf(\\"\\\\n\\");\\n }\\n}\\n\\nint main() {\\n int rows, columns;\\n printf(\\"Enter the number of rows: \\");\\n scanf(\\"%d\\", &rows);\\n printf(\\"Enter the number of columns: \\");\\n scanf(\\"%d\\", &columns);\\n printHollowRectangle(rows, columns);\\n return 0;\\n}",\n "explaination": "This C program generates a hollow rectangle pattern based on the number of rows and columns specified by the user. The program defines a function `printHollowRectangle` that takes two parameters, `rows` and `columns`, to determine the size of the rectangle. Inside this function, nested for loops are used to iterate through each position in the rectangle. The condition `if (i == 1 || i == rows || j == 1 || j == columns)` checks if the current position is on the border of the rectangle (first or last row, first or last column). If so, it prints an asterisk (`*`) to form the border of the rectangle. Otherwise, it prints a space character (` `) to create the hollow effect inside the rectangle. After completing each row, a newline character (`\\\\n`) is printed to move to the next row. The `main` function prompts the user to enter the number of rows and columns, calls the `printHollowRectangle` function with these values, and then ends the program."\n}\n\n\nThis JSON object contains two properties, code and explanation, as required by the schema. The code property holds the source code of the C program designed to print a hollow rectangle pattern. The explanation property provides a detailed description of how the program works, including the logic behind printing the hollow rectangle pattern based on user input for the number of rows and columns.'"""))

# print(model.invoke("Generate a program to convert AImessage to JSON"))