from hashlib import sha512

text_adm = b"admin-nuam"
cypher_adm = sha512(text_adm)

text_aud = b"auditor-nuam"
cypher_aud = sha512(text_aud)

text_cor = b"corredor-nuam"
cypher_cor = sha512(text_cor)

print(f"Admin: {cypher_adm.hexdigest()}")
print(f"Auditor: {cypher_aud.hexdigest()}")
print(f"Corredor: {cypher_cor.hexdigest()}")