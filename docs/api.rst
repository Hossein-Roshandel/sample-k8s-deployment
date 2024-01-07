:tocdepth: 2
API
===

This part of the documentation lists the full API reference of all classes and functions.

WSGI
----

.. autoclass:: quasar_first.wsgi.ApplicationLoader
   :members:
   :show-inheritance:

Config
------

.. automodule:: quasar_first.config

.. autoclass:: quasar_first.config.application.Application
   :members:
   :show-inheritance:

.. autoclass:: quasar_first.config.redis.Redis
   :members:
   :show-inheritance:

.. automodule:: quasar_first.config.gunicorn

CLI
---

.. automodule:: quasar_first.cli

.. autofunction:: quasar_first.cli.cli.cli

.. autofunction:: quasar_first.cli.utils.validate_directory

.. autofunction:: quasar_first.cli.serve.serve

App
---

.. automodule:: quasar_first.app

.. autofunction:: quasar_first.app.asgi.on_startup

.. autofunction:: quasar_first.app.asgi.on_shutdown

.. autofunction:: quasar_first.app.asgi.get_application

.. automodule:: quasar_first.app.router

Controllers
~~~~~~~~~~~

.. automodule:: quasar_first.app.controllers

.. autofunction:: quasar_first.app.controllers.ready.readiness_check

Models
~~~~~~

.. automodule:: quasar_first.app.models

Views
~~~~~

.. automodule:: quasar_first.app.views

.. autoclass:: quasar_first.app.views.error.ErrorModel
   :members:
   :show-inheritance:

.. autoclass:: quasar_first.app.views.error.ErrorResponse
   :members:
   :show-inheritance:

Exceptions
~~~~~~~~~~

.. automodule:: quasar_first.app.exceptions

.. autoclass:: quasar_first.app.exceptions.http.HTTPException
   :members:
   :show-inheritance:

.. autofunction:: quasar_first.app.exceptions.http.http_exception_handler

Utils
~~~~~

.. automodule:: quasar_first.app.utils

.. autoclass:: quasar_first.app.utils.aiohttp_client.AiohttpClient
   :members:
   :show-inheritance:

.. autoclass:: quasar_first.app.utils.redis.RedisClient
   :members:
   :show-inheritance:
