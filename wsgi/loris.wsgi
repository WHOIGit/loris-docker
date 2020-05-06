#!/usr/bin/env python3
from loris.webapp import create_app


application = create_app(debug=False, config_file_path='/etc/loris2.conf')
