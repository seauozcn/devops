from app import *
import pytest


@pytest.fixture()
def test_app():
    test_app = app
    test_app.config.update({
        "TESTING": True,
    })

    yield test_app


@pytest.fixture()
def client(test_app):
    return test_app.test_client()
