python3 -c "import hashlib; ntlm_hash = hashlib.new('md4', 'USERINPUT'.encode('utf-16le')).digest().hex().upper(); print(ntlm_hash)"
