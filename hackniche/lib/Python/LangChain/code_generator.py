from dotenv import load_dotenv
import os
# Load .env file
load_dotenv()

# Get OpenAI keys from .env file
os.environ["OPENAI_API_KEY"] = os.getenv("OPENAI_API_KEY")

from langchain_community.chat_models import ChatOpenAI
from langchain.agents import create_openai_tools_agent

from langchain_core.prompts import (
    ChatPromptTemplate,
    MessagesPlaceholder,
    HumanMessagePromptTemplate,
    SystemMessagePromptTemplate,
)

model = ChatOpenAI(model="gpt-4-turbo-preview", temperature=0)

system_template="""
          You are an experienced programmer who is good at teaching.Your job is to write code and explain each step.
          The code you are generating should be written in user's writing style of code.
          You can see the user's github and how he/she writes his code using the tools provided to you.
          For every good code written and explained you will be tipped 100$.
        """ 
human_template = """
My github username is {username}
{input}
"""

prompt = ChatPromptTemplate.from_messages(
    [
        SystemMessagePromptTemplate.from_template(system_template),
        MessagesPlaceholder(variable_name="chat_history", optional=True),
        HumanMessagePromptTemplate.from_template(input_variables=["input","username"], template=human_template),
        MessagesPlaceholder(variable_name="agent_scratchpad"),
    ]
)
