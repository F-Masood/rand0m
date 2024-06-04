import subprocess

# Path to the input file containing IP addresses or networks
INPUT_FILE = "NZs-IPs-Only.txt"

# Function to flush iptables and add IP address or network to iptables input chain
def add_to_iptables(ip):
    try:
        print(f"Adding {ip} to iptables INPUT chain to allow traffic on ports 80 and 443 only...")
        # Flush existing iptables rules
        subprocess.run(["iptables", "-F"], check=True)
        # Allow traffic on ports 80 and 443 only from the specified IP address
        subprocess.run(["iptables", "-A", "INPUT", "-s", ip, "-p", "tcp", "--dport", "80", "-j", "ACCEPT"], check=True)
        subprocess.run(["iptables", "-A", "INPUT", "-s", ip, "-p", "tcp", "--dport", "443", "-j", "ACCEPT"], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error: Failed to configure iptables rules. Error: {e}")
    except Exception as e:
        print(f"Error: {e}")

# Check if iptables command is available
try:
    subprocess.run(["iptables", "--version"], stdout=subprocess.PIPE, check=True)
except subprocess.CalledProcessError:
    print("Error: iptables command not found. Make sure iptables is installed.")
    exit(1)

# Check if the input file exists
try:
    with open(INPUT_FILE, "r") as file:
        ips = file.readlines()
except FileNotFoundError:
    print(f"Error: Input file '{INPUT_FILE}' not found.")
    exit(1)

# Read each line from the input file and add to iptables
for ip in ips:
    # Remove leading and trailing whitespace from the IP address or network
    ip = ip.strip()
    # Add the IP address or network to iptables
    add_to_iptables(ip)
    
# Block all other traffic on ports 80 and 443
subprocess.run(["iptables", "-A", "INPUT", "-p", "tcp", "--dport", "80", "-j", "DROP"], check=True)
subprocess.run(["iptables", "-A", "INPUT", "-p", "tcp", "--dport", "443", "-j", "DROP"], check=True)
print(f"Allowed traffic from {ip} on ports 80 and 443 successfully. All other traffic on ports 80 and 443 is blocked.")
