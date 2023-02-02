import sys
import os
from flask import Flask, request, jsonify
import flask_cors
# add module execute paths
# sys.path.append("predict_a_line.py")
from flask_cors.decorator import cross_origin
from flask_cors.extension import CORS

from flaskr.predict_a_line import predict_main
from flaskr.generate_respond import RespondDecider, extract_info

def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)
    CORS(app, supports_credentials=True, allow_headers='Authentication', methods=['OPTIONS', 'HEAD', 'GET', 'PUT', 'POST', 'DELETE', 'PATCH'])
    app.config['CORS_HEADERS'] = 'Content-Type'

    app.config.from_mapping(
        SECRET_KEY='dev',
        DATABASE=os.path.join(app.instance_path, 'flaskr.sqlite'),
    )

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    # a simple page that says hello

    @app.route('/hello')
    @cross_origin()
    def hello():
        # return jsonify(res='Hello, this is a chatbot! What can I do for you?')
        return 'Hello, this is a chatbot! What can I do for you?'

    @app.route('/respond', methods=['POST'])
    @cross_origin()
    def respond():
        print(request.json)
        data = request.json['input']
        print(data)

        res = predict_main(data)
        # slot_str = ''
        # for line in res['slots']:
        #     slot_str += line + '\n'
        # return f'Intent:{res["intent"]},\nslots: {res["slots"]}'
        # return 'A dummy respond!'
        rg = RespondDecider(res)
        return rg.extract_info()
        # return extract_info(res)
    return app

create_app()

# set env in terminal:
# > venv\Scripts\activate
# > $env:FLASK_APP='__init__.py'
# > $env:FLASK_ENV='development'
# > cd flaskr
# > flask run