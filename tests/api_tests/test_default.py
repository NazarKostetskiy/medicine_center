
def test_default(test_client):
    response = test_client.get('/')
    assert response.status_code == 200

