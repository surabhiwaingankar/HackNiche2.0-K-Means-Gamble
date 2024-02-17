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

human_template = """
{input}
"""


