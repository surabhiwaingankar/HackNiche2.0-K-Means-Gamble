import os
import re

from langchain.indexes import VectorstoreIndexCreator
from langchain.prompts.chat import (
    ChatPromptTemplate,
    HumanMessagePromptTemplate,
    SystemMessagePromptTemplate,
)
from langchain_community.document_loaders.figma import FigmaFileLoader
from langchain.community_llms import ChatOpenAI

figma_url='https://www.figma.com/file/f6ccmGosJj8UznvLRzpSTT/Cosmic-Gradient-Heroes-%2B-components-(Community)?type=design&node-id=85-1115&mode=design&t=chRKQGTxEkNAMq1C-0'


def extract_file_key(url):
    match = re.search(r'https://www.figma.com/file/([^/]+)/', url)
    if match:
        return match.group(1)
    else:
        raise ValueError("Invalid Figma URL")

def extract_node_ids(url):
    # Extract node IDs from the URL using regular expression
    node_id_matches = re.findall(r'\?node-id=([^&]+)', url)
    return node_id_matches

print(extract_file_key("https://www.figma.com/file/f6ccmGosJj8UznvLRzpSTT/Cosmic-Gradient-Heroes-%2B-components-(Community)?type=design&node-id=85-1115&mode=design&t=chRKQGTxEkNAMq1C-0"))
print(extract_node_ids("https://www.figma.com/file/f6ccmGosJj8UznvLRzpSTT/Cosmic-Gradient-Heroes-%2B-components-(Community)?type=design&node-id=85-1115&mode=design&t=chRKQGTxEkNAMq1C-0"))