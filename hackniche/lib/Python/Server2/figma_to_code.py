import os
import webbrowser
import argparse
from langchain.document_loaders.figma import FigmaFileLoader
from langchain.chat_models import ChatOpenAI
from langchain.indexes import VectorstoreIndexCreator
from langchain.prompts.chat import (
    ChatPromptTemplate,
    SystemMessagePromptTemplate,
    HumanMessagePromptTemplate,
)
from langchain.vectorstores import Chroma
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Initialize the FigmaFileLoader with environment variables
figma_loader = FigmaFileLoader(
    os.environ.get('ACCESS_TOKEN'),
    os.environ.get('NODE_IDS'),
    os.environ.get('FILE_KEY'),
)

# Create an index and retriever for Figma documents
index = VectorstoreIndexCreator().from_loaders([figma_loader])
figma_doc_retreiver = index.vectorstore.as_retriever()

# Define system and human prompt templates
system_prompt_template = """You are a senior developer.
Use the provided design context to create idiomatic HTML/CSS code based on the user request.
Everything must be inline in one file and your response must be directly renderable by the browser.
Write code that matches the Figma file nodes and metadata as exactly as you can.
Figma file nodes and metadata: {context}"""

human_prompt_template = "Code the {text}. Ensure that the code is mobile responsive and follows modern design principles."

# Initialize the ChatOpenAI model
gpt_4 = ChatOpenAI(temperature=.03, model_name='gpt-3.5-turbo', request_timeout=120)

print("hii")


