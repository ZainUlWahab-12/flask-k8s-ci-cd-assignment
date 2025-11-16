from flask import Flask, jsonify


app = Flask(__name__)


@app.route("/")
def hello():
    return "Hello, World!"


@app.route("/health")
def health():
    return jsonify(status="ok")


if __name__ == "__main__":
    # Use 0.0.0.0 so container binds externally; port 5000 by convention for Flask
    app.run(host="0.0.0.0", port=5000)
