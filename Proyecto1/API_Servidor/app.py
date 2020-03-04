from flask import Flask
from flask import render_template, request, flash
from flask import redirect, url_for
from flask import jsonify
import models as coneccion

app = Flask(__name__)

##Settings
app.secret_key = 'secreto'

@app.route('/')
def index():
    return render_template('index.html')

##Consultas
@app.route('/cajero')
def cajero():
    datos = coneccion.consulta_cuenta_all()
    resp  =jsonify(datos)
    return resp

@app.route('/cajero/<id>')
def cajero2(id):
    datos1 = coneccion.consulta_cuenta(id)
    datos = coneccion.actualiza_fecha(id)
    resp = jsonify(datos1)
    return resp

@app.route('/usuario')
def usuario():
    datos = coneccion.consulta_cuenta_all()
    resp = jsonify(datos)
    return resp

@app.route('/fechaConsulta/<id>')
def fecha(id ):
    datos = coneccion.actualiza_fecha(id)
    resp  =jsonify(datos)
    return resp

@app.route('/usuario/<id>')
def usuario2(id):
    datos1 = coneccion.actualiza_fecha(id)
    datos = coneccion.consulta_usuario(id)
    resp = jsonify(datos)
    return resp

@app.route('/fechaConsulta/<id>')
def fecha2():
    datos = coneccion.actualiza_fecha(id)
    resp  =jsonify(datos)
    return resp

##Delete
@app.route('/cajero/eliminar/<id>')
def cajero3(id):
    datos = coneccion.consulta_cuenta(id)
    resp = jsonify(datos)
    return resp

@app.route('/usuario/eliminar/<id>')
def usuario3(id):
    datos = coneccion.consulta_usuario(id)
    resp = jsonify(datos)
    return resp

@app.route('/respuesta/<id>')
def respuesta(id):
    datos = coneccion.consulta_cuenta(id)
    usuario = coneccion.consulta_usuario(id)
    resp = datos
    return render_template('cajero.html', messages=resp, usuario=usuario)


@app.route('/lista_cuentas/')
def lista_cuentas():
    messages = coneccion.consulta_cuenta_all()
    print(messages)
    return render_template('cuentas.html', messages=messages)

##Update
############################################################################
@app.errorhandler(404)
def not_found(error=None):
    message = {
        'status' : 404,
        'message' : 'Not Found ' + request.url,
    }
    resp = jsonify(message)
    return resp

if __name__ == '__main__':
    app.run(debug =True)