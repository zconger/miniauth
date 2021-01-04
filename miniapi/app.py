#!/usr/bin/env python
import json
from flask import Flask, make_response

app = Flask(__name__)


@app.route('/')
def index():
    resp = make_response(
        json.dumps(
            {
                'name': 'Hello World!',
                'email': 'hello@world.com'
            }
        )
    )
    # resp.headers['X-Content-Type-Options'] = 'nosniff'
    return resp


if __name__ == "__main__":
    app.run(host='0.0.0.0')
