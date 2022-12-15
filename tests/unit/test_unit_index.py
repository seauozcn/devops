def test_hello(client):
    response = client.post(
        "/hello",
        data=dict(name="devoops"),
        follow_redirects=True
    )

    assert response.status_code == 200
    assert b'devoops' in response.data
