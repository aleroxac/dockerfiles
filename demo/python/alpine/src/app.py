from flask import Flask, Response
from json import dumps

app = Flask("demo-python-alpine")

@app.route("/api/v1/healthcheck")
def healthcheck():
    return {"status":"OK"}

if __name__ == "__main__":
    app.run(debug=False, host="0.0.0.0", port=8000)
