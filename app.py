from flask import Flask, jsonify
import socket

app = Flask(__name__)

@app.get("/hostname")
def hostname():
    return jsonify({"hostname": socket.gethostname()})

@app.get("/health")
def health():
    return jsonify({"status": "ok"})

if __name__ == "__main__":
    # Flask listens internally; nginx will be the public entrypoint
    app.run(host="0.0.0.0", port=5000)