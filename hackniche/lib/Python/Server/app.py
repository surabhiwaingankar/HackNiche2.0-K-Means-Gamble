from flask import Flask, request, jsonify
import requests
import base64
app = Flask(__name__)

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

if __name__ == "__main__":
  app.run() 