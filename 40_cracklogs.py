# Python script to match hash values from two files and write the matched results to logs.txt

# File paths
file1_path = 'file1.txt'
file2_path = 'file2.txt'
output_path = 'logs.txt'

#file1 = domain\username1:hash1 e.g mydomain\john:2839283928392839238923
#file2 = hash1:CrackedPlaintext1 e.g. 2839283928392839238923:Password1
#logs = domain\username1:hash1 e.g mydomain\john:2839283928392839238923:Password1

# Read and process file2 to create a dictionary of hash to plaintext values
hash_to_plaintext = {}
with open(file2_path, 'r') as file2:
    for line in file2:
        hash_value, plaintext = line.strip().split(':', 1)
        hash_to_plaintext[hash_value] = plaintext

# Initialize counters
total_accounts = 0
total_matches = 0

# Process file1 and write the matched results to logs.txt
with open(file1_path, 'r') as file1, open(output_path, 'w') as output_file:
    for line in file1:
        total_accounts += 1
        parts = line.strip().split(':')
        if len(parts) == 2:
            user_info, hash_value = parts
            if hash_value in hash_to_plaintext:
                total_matches += 1
                plaintext = hash_to_plaintext[hash_value]
                output_file.write(f'{user_info}:{hash_value}:{plaintext}\n')

# Print verbose output
print(f'Total number of accounts in file1: {total_accounts}')
print(f'Total number of hashes matched: {total_matches}')

print(f'Matching results have been written to {output_path}')
