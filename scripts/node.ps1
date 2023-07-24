# Install Node.JS
If (-Not (Test-Path 'C:\Program Files\nodejs')){
    echo "Downloading Node + NPM..."
    Invoke-WebRequest -Uri "https://nodejs.org/dist/.4.7/node-v4.4.7-x64.msi" -OutFile "node.msi"
    msiexec /quiet /i node.msi
    echo "Node installed."
}
