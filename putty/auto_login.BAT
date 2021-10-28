echo "Load private key for tool01."
START "C:\Program Files (x86)\PuTTY\pageant.exe" c:\ssh_keys\id_rsa.ppk
echo "Done!"
echo "Load private key for my workstation."
START "C:\Program Files (x86)\PuTTY\pageant.exe" c:\ssh_keys\bku-E5510-id_rsa.ppk
echo "Done!"