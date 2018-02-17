from flask import Flask, jsonify, request
from jinja2 import Template

app = Flask(__name__)

class InvalidUsage(Exception):
    status_code = 400

    def __init__(self, message, status_code=None, payload=None):
        Exception.__init__(self)
        self.message = message
        if status_code is not None:
            self.status_code = status_code
        self.payload = payload

    def to_dict(self):
        rv = dict(self.payload or ())
        rv['message'] = self.message
        return rv

@app.errorhandler(InvalidUsage)
def handle_invalid_usage(error):
    response = jsonify(error.to_dict())
    response.status_code = error.status_code
    return response


@app.route('/', methods=["POST"])
def generate():
    """
    Generates custom ERC-721 contracts from common patterns. Note: Args are passed as data in a POST request.

    Args:
        registry_type: Name of the base registry: 'MintableRegistry' or 'NonMintableRegistry'
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
    templates = {}

    req_json = request.get_json()
    data = {
        'REGISTRY_TYPE': req_json.get('registry_type'),
        'NAME': req_json.get('name'),
        'SYMBOL': req_json.get('symbol'),
        'DESC': req_json.get('desc'),
        'NUM_TOKENS': req_json.get('num_tokens'),
        'URL': req_json.get('url')
    }

    # read in template
    try:
        contract_file = "templates/{}.sol".format(data['REGISTRY_TYPE'])
        with open(contract_file, 'r') as fh:
            templates[data['REGISTRY_TYPE']] = Template(fh.read()).render(**data)
    except IOError as e:
        raise InvalidUsage("Unable to open {}".format(contract_file))

    return jsonify(templates)
