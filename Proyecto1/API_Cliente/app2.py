from flask import Flask
from flask import render_template, request, flash
from flask import redirect, url_for
from flask import jsonify
import json, requests
app = Flask(__name__)

##Settings
app.secret_key = 'secreto2'

@app.route('/')
def index():
    return render_template('index.html')


@app.route('/cajero', methods=['POST'])
def cajero():
    if request.method == 'POST':
        idc = request.form['idc']
        fecha = request.form['fecha']
        ruta = 'http://127.0.0.1:5000/cajero/' + idc
        try:
            datos = requests.get(ruta)
            resp = json.loads(datos.content)
            print(resp)
        except:
            return 'Hubo un error'
    return render_template('cajero.html', messages=resp)

@app.route('/usuario', methods=['POST'])
def usuario():
    if request.method == 'POST':
        usuario_id = request.form['usuario_id']
        nombre = request.form['nombre']
        ap_pat = request.form['ap_pat']
        ruta = 'http://127.0.0.1:5000/usuario/' + usuario_id
        try:
            datos = requests.get(ruta)
            resp = json.loads(datos.content)
            print(resp)
        except:
            return 'Hubo un error'
    return render_template('cuentas.html', messages=resp)

@app.errorhandler(404)
def not_found(error=None):
    message = {
        'status' : 404,
        'message' : 'Not Found ' + request.url,
    }
    resp = jsonify(message)
    return resp

if __name__ == '__main__':
    app.run(debug =True, port = 9000)