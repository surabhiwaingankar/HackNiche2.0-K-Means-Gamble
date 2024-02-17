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
          You are a tool used for code analysis. Your job is to analyze the code provided to you.
          On every code provided to you , you have to perform  the following analysis:
          Syntax and Style Check:
          Code Smells Count : 
           Code Duplication Percentage:
           Bug Detection :
           No of defects :
        Do not explain the code . Just provide the analysis and provide numeric count for each of the code above.
        """ 
human_template = """
{input}
"""

prompt = ChatPromptTemplate.from_messages(
    [
        SystemMessagePromptTemplate.from_template(system_template),
        MessagesPlaceholder(variable_name="chat_history", optional=True),
        HumanMessagePromptTemplate.from_template(input_variables=["input"], template=human_template),
        MessagesPlaceholder(variable_name="agent_scratchpad"),
    ]
)
print (model.invoke("""
             #include <stdio.h>
             #include <stdio.h>
#include <stdlib.h>
#include <stdlib.h>
#include <stdlib.h>
#include <stdlib.h>

// Function prototypes
void mergeSort(int arr[], int l, int r);
void merge(int arr[], int l, int m, int r);

// Main function to demonstrate merge sort
int main() {
    int arr[] = {12, 11, 13, 5, 6, 7};
    int arr_size = sizeof(arr) / sizeof(arr[0]);

    printf("Given array is \n");
    for (int i = 0; i < arr_size; i++)
        printf("%d ", arr[i]);
    printf("\n");

    // Sorting the array
    mergeSort(arr, 0, arr_size - 1);

    printf("\nSorted array is \n");
    for (int i = 0; i < arr_size; i++)
        printf("%d ", arr[i]);
    printf("\n");
    return 0;
}

// MergeSort function
void mergeSort(int arr[], int l, int r) {
    if (l < r) {
        // Same as (l+r)/2, but avoids overflow for large l and h
        int m = l + (r - l) / 2;

        // Sort first and second halves
        mergeSort(arr, l, m);
        mergeSort(arr, m + 1, r);

        merge(arr, l, m, r);
    }
}

// Function to merge the two halves
void merge(int arr[], int l, int m, int r) {
    int i, j, k;
    int n1 = m - l + 1;
    int n2 = r - m;
             """)
)
