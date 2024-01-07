"""A sample fastapi app to be deployed on Kubernetes"""
import logging

from quasar_first.wsgi import ApplicationLoader
from quasar_first.version import __version__

# initialize logging
log = logging.getLogger(__name__)
log.addHandler(logging.NullHandler())

__all__ = ("ApplicationLoader", "__version__")
