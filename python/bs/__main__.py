import sys
from .commands import main, parser

sys.exit(main(parser.parse_args()))