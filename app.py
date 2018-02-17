from flask import Flask, jsonify, request
app = Flask(__name__)

@app.route('/', methods=["POST"])
def generate():
    """
    Generates custom ERC-721 contracts from common patterns. Note: Args are passed as data in a POST request.

    Args:
        registry_type: Name of the base registry: 'mintable' or 'nonmintable'
        name: Registry name, parent name for all tokens.
        symbol: 2-4 letter ticket symbol for the tokens.
        desc: Short description of the registry.
        num_tokens: Generates this many tokens at deploy.
        url: JSON metadata url, when present all tokens minted receive this metadata.

    Returns:
        A JSON object containing all applicable contracts.

    Raises:
        ...something probably...
    """
    req_json = request.get_json()
    return jsonify({
        'registry_type': req_json.get('registry_type'),
        'name': req_json.get('name'),
        'symbol': req_json.get('symbol'),
        'desc': req_json.get('desc'),
        'num_tokens': req_json.get('num_tokens'),
        'url': req_json.get('url')
        })
