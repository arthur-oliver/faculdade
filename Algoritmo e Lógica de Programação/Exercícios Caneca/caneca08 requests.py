import requests
url = 'https://fatec-cafe.glitch.me/vip'

import time
preço = 99.99
while preço >= 4.74:
    texto = requests.get(url).text 
    onde = texto.find('R$')
    inicio = onde + 2
    fim = inicio + 4
    preço = float(texto[inicio:fim])
    if preço >= 4.74:
        time.sleep(600) 
print (f'Comprar! R$ {preço:.2f}')

