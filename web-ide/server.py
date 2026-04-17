from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
import subprocess
import os

app = Flask(__name__, template_folder='templates')
CORS(app, resources={r"/*": {"origins": "*"}})

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/execute', methods=['POST'])
def execute():
    code = request.json.get('code', '') + "\n"
    
    try:
        # Chemin vers nutrilang (comme compilé par ton script)
        base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        compiler_path = os.path.join(base_dir, 'nutrilang')
        
        if not os.path.exists(compiler_path):
            return jsonify({'output': '❌ ERREUR : Le compilateur "nutrilang" est introuvable.\nExécutez ./compile.sh d\'abord.'})
        
        process = subprocess.Popen(
            [compiler_path],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            encoding='utf-8'
        )
        
        stdout, stderr = process.communicate(input=code, timeout=10)
        output = stdout + stderr
        
        if not output.strip():
            output = "✅ Exécution terminée avec succès."
            
        return jsonify({'output': output})
        
    except subprocess.TimeoutExpired:
        return jsonify({'output': '⚠️ Timeout (10s) - Possible boucle infinie ?'})
    except Exception as e:
        return jsonify({'output': f'❌ Erreur serveur : {str(e)}'})

if __name__ == '__main__':
    print("🚀 NutriLang Studio — http://localhost:5000")
    app.run(host='0.0.0.0', port=5000, debug=True)