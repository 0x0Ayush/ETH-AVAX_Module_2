#ENS Domain dApp

This repository contains a decentralized application (dApp) for managing Ethereum Name Service (ENS) domains. It allows users to create, list, and buy ENS domains using the Ethereum blockchain. The dApp is built using Solidity smart contracts and integrated with MetaMask Wallet !! 

#Smart Contract

The core functionality of the dApp is implemented in the ```ENSMarketplace smart contract.``` It inherits from the **ERC721** standard and extends the **ERC721URIStorage** and **Ownable contract**s from the OpenZeppelin library. The contract includes the following functions:

#createENS
This function allows users to create a new ENS domain by providing a name for the domain. It mints a new token representing the ENS domain and assigns it to the creator.

#listENSForSale
Owners of ENS domains can use this function to list their domains for sale. They must specify the token ID and the price in Ether at which they want to sell the domain.

#getENSPrice
This function allows users to retrieve the price of an ENS domain listed for sale.

#isTokenListedForSale
This function checks if a given ENS domain token is listed for sale.

#getTokenURI
This function returns the metadata URI associated with a given ENS domain token.

#Frontend (HTML | CSS | JS)
The dApp's frontend is a simple web page built using HTML, CSS, and JavaScript. It uses the MetaMask browser extension for wallet connectivity. Users can connect their wallets, create new ENS domains, list them for sale, and buy listed domains.

#HTML
The HTML file (index.html) provides the basic structure of the webpage. It includes a container div for displaying the content and buttons for various actions.

#CSS
The CSS file (main.css) defines the visual styling of the webpage, making it visually appealing and user-friendly.

#JavaScript
The JavaScript file (main.js) handles the integration with MetaMask, communication with the smart contract, and updates the frontend based on user interactions.

#Getting Started
To use the dApp, follow these steps:

Ensure you have the MetaMask extension installed in your browser and are connected to the Ethereum network.
Clone this repository and open the project folder.
Deploy the ENSMarketplace smart contract to your preferred Ethereum network (e.g., Ropsten, Rinkeby, or Mainnet).
Update the contractAddress and contractABI variables in main.js with the deployed contract's address and ABI.
Host the frontend files (index.html, main.css, and main.js) on a web server or use a development server to view the dApp in your browser.
Access the dApp through the web server, and you should be able to interact with the ENS Domain Daap.
