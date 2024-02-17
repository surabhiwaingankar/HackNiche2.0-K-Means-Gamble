from flask import Flask, request, jsonify
import requests
import base64
import figma_to_code
import json

app = Flask(__name__)

@app.route('/ui/to/code', methods=['POST'])
def ui_to_code():
    data = request.get_json()
    print(data)
    figma_file_link = data['figma_file_link']
    figma_to_code.generate_code()
    return jsonify({"status": "success"})

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


