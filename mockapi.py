import requests

# Thay 'user' thành 'users' nếu đó là tên bạn đặt trên MockAPI
url = 'https://695c8ccc79f2f34749d48412.mockapi.io/api/user/user'

response = requests.get(url).json()
print(response)