"""
Simple REST API
"""
import os
import sys
from flask import Flask, request
from flask_restful import Resource, Api
from flask_cors import CORS
import requests

app = Flask(__name__)
CORS(app)
api = Api(app)

# Get port from environment variable or choose 9090 as local default
port = int(os.getenv("PORT", 9090))

# Respond to a GET /
@app.route('/')
def index():
    print "Output from from python rest api"
    return 'Index Page'

if __name__ == '__main__':
    # Run the app, listening on all IPs with our chosen port number
    app.run(host='0.0.0.0', port=port, debug=True)
    print 'Exiting...doh'
