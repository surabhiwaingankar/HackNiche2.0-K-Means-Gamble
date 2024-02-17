from flask import Flask, request, jsonify
import requests
import base64
import code_generator, code_analysis, langchain_agent
import json
from flask_cors import CORS
app = Flask(__name__)

CORS(app)
@app.route('/create/repo', methods=['POST'])
def create_repo():
    data = request.get_json()
    name = data["name"]
    description = data["description"]
    private = data["private"]
    token = data["token"]
    #print(name, description, private, token)
    url = f'https://api.github.com/user/repos'
    headers = {"Authorization": "Bearer "+token}
    data = {
        "name": name,
        "description": description,
        "private": private
    }
    response = requests.post(url, headers=headers, json=data)
    return jsonify({"message": "Repository created successfully!"})

@app.route('/delete/repo', methods=['POST'])
def delete_repo():
    data = request.get_json()
    username = data["username"]
    repo_name = data["repo_name"]
    token = data["token"]
    url = f'https://api.github.com/repos/{username}/{repo_name}'
    headers = {"Authorization": "Bearer "+token}
    response = requests.delete(url, headers=headers)
    return jsonify({"message": "Repository deleted successfully!"})

@app.route('/upload/file', methods=['POST'])
def upload_file():
    data = request.get_json()
    username = data["username"]
    repo_name = data["repo_name"]
    file_name = data["file_name"]
    token = data["token"]
    encoded_file_data = data["encoded_file_data"]
    url = f"https://api.github.com/repos/{username}/{repo_name}/contents/{file_name}"
    headers = {"Authorization": "Bearer "+token}
    data = {
        "message": f"created {file_name}",
        "content": encoded_file_data
    }
    response = requests.put(url, headers=headers, json=data)
    return jsonify({"message": "File uploaded successfully!"})

@app.route('/delete/file', methods=['POST'])
def delete_file():
    data = request.get_json()
    username = data["username"]
    repo_name = data["repo_name"]
    file_name = data["file_name"]
    token = data["token"]
    url1 = f"https://api.github.com/repos/{username}/{repo_name}/contents/{file_name}?ref=main"
    headers1 = {"Authorization": "Bearer "+token}
    response = requests.get(url1, headers=headers1)
    sha = response.json()["sha"]
    url2 = f'https://api.github.com/repos/{username}/{repo_name}/contents/{file_name}'
    headers2 = {"Authorization": "Bearer "+token}
    data = {
        "message": f"deleted {file_name}",
        "sha": sha
    }
    response = requests.delete(url2, headers=headers2, json=data)
    #print(response.json())
    return jsonify({"message": "File deleted successfully!"})

@app.route('/get/repos', methods=['POST'])
def get_repos():
    data = request.get_json()
    username = data["username"]
    token = data["token"]
    url = f'https://api.github.com/users/{username}/repos'
    headers = {"Authorization": "Bearer "+token}
    response = requests.get(url, headers=headers)
    # print(response.json())
    repo_names = []
    for repo in response.json():
        repository_name = repo["name"]
        repo_names.append(repository_name)
        print(repo_names)
    return jsonify({"repos": repo_names})

@app.route('/generate/code', methods=['POST'])
def generate_code():
    data = request.get_json()
    input = data["input"]
    output = code_generator.generate_code(input)
    # json_obj = json.loads(output)
    string_output= str(output)
    response=slice_json(string_output)
    return response

@app.route('/analyze/code', methods=['POST'])
def analyze_code():
    data = request.get_json()
    code = data["input"]
    output = code_analysis.analyse_code(code)
    string_output= str(output)
    response=slice_json(string_output)
    return response

# @app.route('/ui/to/code', methods=['POST'])
# def ui_to_code():
    
@app.route('/generate/langchain', methods=['POST'])
def scrape_docs():
    data = request.get_json()
    input = data["input"]
    output = langchain_agent.scraping_documentation(input)
    print(output)
    string_output= str(output)
    response=slice_json(string_output)
    return response

def slice_json(content):
    start_index = content.find('{')
    end_index = content.rfind('}')
    json_part = content[start_index:end_index+1]
    # print(json_part)
    unescaped_json_string = json_part.encode().decode('unicode_escape')
    print(unescaped_json_string)
    json_data = json.loads(unescaped_json_string)
    return json_data

if __name__ == "__main__":
  app.run() 


